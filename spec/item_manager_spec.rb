# frozen_string_literal: true

require 'tmpdir'
require 'fileutils'
require_relative '../lib/lost_and_found/item_manager'
require_relative '../lib/lost_and_found/repositories/item_repository'
require_relative '../lib/lost_and_found/storage/database'
require_relative '../lib/lost_and_found/models/lost_item'
require_relative '../lib/lost_and_found/models/found_item'

RSpec.describe ItemManager do
  let(:db_path) { File.join(Dir.mktmpdir, 'items.sqlite3') }

  after do
    FileUtils.rm_rf(File.dirname(db_path))
  end

  def build_manager
    ItemManager.new(ItemRepository.new(Database.connect(db_path)))
  end

  describe 'on first run' do
    it 'starts with no items when the database file does not exist yet' do
      manager = build_manager

      expect(manager.all_items).to eq([])
    end
  end

  describe '#add_item' do
    it 'assigns a unique id and writes the record to the database' do
      manager = build_manager
      item = LostItem.new(name: 'Black Wallet', location: 'Library')

      manager.add_item(item)

      expect(item.id).not_to be_nil
      expect(manager.all_items.map(&:name)).to eq(['Black Wallet'])
    end
  end

  describe 'persistence across instances' do
    it 'loads previously saved records on startup' do
      build_manager.add_item(LostItem.new(name: 'Black Wallet', location: 'Library'))
      build_manager.add_item(FoundItem.new(name: 'Car Keys', location: 'Gym'))

      reloaded = build_manager.all_items

      expect(reloaded.map(&:name)).to contain_exactly('Black Wallet', 'Car Keys')
      expect(reloaded.map(&:class)).to contain_exactly(LostItem, FoundItem)
    end
  end

  describe '#search_items' do
    it 'filters items by a partial, case-insensitive match' do
      manager = build_manager
      manager.add_item(LostItem.new(name: 'Black Backpack', location: 'Library'))
      manager.add_item(LostItem.new(name: 'Car Keys', location: 'Gym'))

      results = manager.search_items(name: 'backpack')

      expect(results.map(&:name)).to eq(['Black Backpack'])
    end
    it 'searches items by category' do
      manager = build_manager

      manager.add_item(
        LostItem.new(
          name: 'Black Wallet',
          category: 'Wallet',
          location: 'Library'
        )
      )

      manager.add_item(
        LostItem.new(
          name: 'Car Keys',
          category: 'Keys',
          location: 'Gym'
        )
      )

      results = manager.search_items(category: 'wallet')

      expect(results.map(&:name)).to eq(['Black Wallet'])
    end

    it 'searches items by location' do
      manager = build_manager

      manager.add_item(
        LostItem.new(
          name: 'Black Wallet',
          category: 'Wallet',
          location: 'Evans Library'
        )
      )

      manager.add_item(
        LostItem.new(
          name: 'Car Keys',
          category: 'Keys',
          location: 'Gym'
        )
      )

      results = manager.search_items(location: 'library')

      expect(results.map(&:name)).to eq(['Black Wallet'])
    end
  end

  describe '#update_status' do
    it "updates a lost item's status from Lost to Returned and persists the change" do
      manager = build_manager

      item = LostItem.new(
        name: 'Black Wallet',
        location: 'Library'
      )

      manager.add_item(item)

      expect(manager.find_item(item.id).status).to eq(Status::LOST)

      manager.update_status(item.id, Status::RETURNED)

      reloaded_manager = build_manager
      updated_item = reloaded_manager.find_item(item.id)

      expect(updated_item.status).to eq(Status::RETURNED)
    end
  end

    describe "#lost_items" do
    it "records a lost item correctly" do
      manager = build_manager

      item = LostItem.new(
        name: "Black Wallet",
        description: "Black leather wallet",
        category: "Wallet",
        location: "Library",
        date_lost: "09/25/2026"
      )

      manager.add_item(item)

      lost_items = manager.lost_items

      expect(lost_items.length).to eq(1)

      saved_item = lost_items.first

      expect(saved_item.name).to eq("Black Wallet")
      expect(saved_item.description).to eq("Black leather wallet")
      expect(saved_item.category).to eq("Wallet")
      expect(saved_item.location).to eq("Library")
      expect(saved_item.date).to eq("09/25/2026")
      expect(saved_item.status).to eq(Status::LOST)
    end
  end

  describe "#found_items" do
    it "records a found item correctly" do
      manager = build_manager

      item = FoundItem.new(
        name: "Car Keys",
        description: "Toyota key fob",
        category: "Keys",
        location: "Gym",
        date_found: "09/25/2026"
      )

      manager.add_item(item)

      found_items = manager.found_items

      expect(found_items.length).to eq(1)

      saved_item = found_items.first

      expect(saved_item.name).to eq("Car Keys")
      expect(saved_item.description).to eq("Toyota key fob")
      expect(saved_item.category).to eq("Keys")
      expect(saved_item.location).to eq("Gym")
      expect(saved_item.date).to eq("09/25/2026")
      expect(saved_item.status).to eq(Status::FOUND)
    end
  end
end

