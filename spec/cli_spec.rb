# frozen_string_literal: true

require 'open3'
require 'stringio'
require_relative '../lib/lost_and_found/cli'
require_relative '../lib/lost_and_found/item_manager'

RSpec.describe 'Lost & Found CLI' do
  let(:app) { File.expand_path('../bin/lost_and_found', __dir__) }

  describe 'launching the application' do
    it 'launches the terminal with a welcome message' do
      output, = Open3.capture3(app, stdin_data: '')

      expect(output).to include('Lost & Found Tracker')
      expect(output).to include(
        "Type './bin/lost_and_found --help' for available commands."
      )
    end
  end

  describe '--help' do
    it 'displays all available commands' do
      output = `#{app} --help`

      expect(output).to include('Lost & Found Tracker')
      expect(output).to include('Usage:')
      expect(output).to include('add-lost')
      expect(output).to include('add-found')
      expect(output).to include('list')
      expect(output).to include('search')
      expect(output).to include('match ID')
      expect(output).to include('return ID')
      expect(output).to include('help')
      expect(output).to include('-h, --help')
    end
  end
end

class FakeItemRepository
  def initialize
    @items = {}
    @next_id = 1
  end

  def create(item)
    item.id = @next_id
    @next_id += 1
    @items[item.id] = item
    item
  end

  def find(id)
    @items[id]
  end

  def all
    @items.values
  end

  def search(filters = {})
    all.select do |item|
      filters.all? { |field, value| item.public_send(field).to_s.downcase.include?(value.to_s.downcase) }
    end
  end

  def update(item)
    @items[item.id] = item
  end

  def delete(id)
    @items.delete(id)
  end
end

RSpec.describe LostAndFound::CLI do
  let(:manager) { ItemManager.new(FakeItemRepository.new) }
  let(:output) { StringIO.new }

  def run_cli(script)
    described_class.new(item_manager: manager, input: StringIO.new(script), output: output, args: []).run
  end

  describe 'the main menu loop' do
    it 'displays the menu and exits cleanly when the user quits' do
      run_cli("8\n")

      expect(output.string).to include('1. Add a lost item')
      expect(output.string).to include('5. List all lost items')
      expect(output.string).to include('6. List all found items')
      expect(output.string).to include('7. List all returned items')
      expect(output.string).to include('8. Quit')
      expect(output.string).to include('Goodbye!')
    end

    it 'exits cleanly instead of hanging when input runs out (EOF)' do
      run_cli('')

      expect(output.string).to include('Goodbye!')
    end

    it 'reports unknown choices and keeps looping instead of crashing' do
      run_cli("9\n8\n")

      expect(output.string).to include("Unknown option '9'")
      expect(output.string).to include('Goodbye!')
    end
  end

  describe 'adding a lost item' do
    it 'records it and shows it back in the list' do
      run_cli("1\nBlack Wallet\nLibrary\nLeather\nAccessory\n09/01/2026\n3\n\n\n\n8\n")

      expect(manager.all_items.map(&:name)).to eq(['Black Wallet'])
      expect(output.string).to include('Added lost item: Black Wallet')
      expect(output.string).to include('Black Wallet')
    end

    it 're-prompts instead of crashing when the required name is blank' do
      run_cli("1\n\nBlack Wallet\nLibrary\n\n\n\n8\n")

      expect(output.string).to include('Item name is required.')
      expect(manager.all_items.map(&:name)).to eq(['Black Wallet'])
    end
  end

  describe 'adding a found item' do
    it 'records it with Found status' do
      run_cli("2\nCar Keys\nGym\n\n\n\n8\n")

      expect(manager.all_items.map(&:status)).to eq(['Found'])
    end
  end

  describe 'listing items by status' do
    it 'lists lost items only' do
      run_cli("1\nBlack Wallet\nLibrary\n\n\n09/01/2026\n2\nCar Keys\nGym\n\n\n09/02/2026\n5\n8\n")

      expect(output.string).to include('ID: 1 | Black Wallet')
      expect(output.string).not_to include('ID: 2 | Car Keys')
    end

    it 'lists found items only' do
      run_cli("1\nBlack Wallet\nLibrary\n\n\n09/01/2026\n2\nCar Keys\nGym\n\n\n09/02/2026\n6\n8\n")

      expect(output.string).to include('ID: 2 | Car Keys')
      expect(output.string).not_to include('ID: 1 | Black Wallet')
    end

    it 'shows a message when there are no found items' do
      run_cli("6\n8\n")

      expect(output.string).to include('No found items found.')
    end

    it 'does not prompt for match filters when there are no found items' do
      run_cli("1\nBlack Wallet\nLibrary\n\n\n09/01/2026\n3\n8\n")

      expect(output.string).to include('No items found.')
      expect(output.string).not_to include('Name contains')
      expect(output.string).not_to include('ID: 1 | Black Wallet')
    end

    it 'lists returned items only' do
      run_cli("1\nBlack Wallet\nLibrary\n\n\n\n2\nCar Keys\nGym\n\n\n\n4\n1\n7\n8\n")

      expect(output.string).to include('ID: 1 | Black Wallet')
      expect(output.string).not_to include('ID: 2 | Car Keys')
    end
  end

  describe 'marking an item as returned' do
    it 'updates the status of an existing item' do
      run_cli("1\nBlack Wallet\nLibrary\n\n\n\n8\n")
      id = manager.all_items.first.id

      run_cli("4\n#{id}\n8\n")

      expect(manager.find_item(id).status).to eq('Returned')
      expect(output.string).to include("Item ##{id} marked as returned.")
    end

    it 'shows an error for an id that does not exist' do
      run_cli("4\n999\n8\n")

      expect(output.string).to include('No item found with ID 999.')
    end
  end
end
