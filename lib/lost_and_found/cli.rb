# frozen_string_literal: true

require_relative 'constants'
require_relative 'item_manager'
require_relative 'repositories/item_repository'
require_relative 'models/lost_item'
require_relative 'models/found_item'
require_relative 'ui/prompts'
require_relative 'ui/formatter'

module LostAndFound
  class CLI
    def self.start
      new.run
    end

    def initialize(item_manager: ItemManager.new(ItemRepository.new), input: $stdin, output: $stdout, args: ARGV)
      @item_manager = item_manager
      @args = args
      @output = output
      @prompts = Prompts.new(input: input, output: output)
      @formatter = Formatter.new(output: output)
    end

    def run
      if @args.include?('--help') || @args.include?('-h')
        help
      else
        @output.puts 'Lost & Found Tracker'
        @output.puts "Type './bin/lost_and_found --help' for available commands."
        main_loop
      end
    end

    private

    def main_loop
      loop do
        @prompts.show_menu
        choice = @prompts.read_choice

        case choice
        when '1' then add_lost_item
        when '2' then add_found_item
        when '3' then find_matches
        when '4' then mark_returned
        when '5' then list_lost_items
        when '6' then list_found_items
        when '7' then list_returned_items
        when '8', nil then break
        else
          @formatter.error("Unknown option '#{choice}'. Please choose 1-8.")
        end
      end

      @output.puts 'Goodbye!'
    end

    def add_lost_item
      name = @prompts.ask_required('Item name')
      return if name.nil?

      location = @prompts.ask_required('Location')
      return if location.nil?

      description = @prompts.ask('Description')
      category = @prompts.ask('Category')
      date_lost = @prompts.ask_date('Date lost')

      item = LostItem.new(
        name: name,
        location: location,
        description: description,
        category: category,
        date_lost: date_lost
      )

      @item_manager.add_item(item)
      @formatter.message("Added lost item: #{item.name}")
    end

    def add_found_item
      name = @prompts.ask_required('Item name')
      return if name.nil?

      location = @prompts.ask_required('Location')
      return if location.nil?

      description = @prompts.ask('Description')
      category = @prompts.ask('Category')
      date_found = @prompts.ask_date('Date found')

      item = FoundItem.new(
        name: name,
        location: location,
        description: description,
        category: category,
        date_found: date_found
      )

      @item_manager.add_item(item)
      @formatter.message("Added found item: #{item.name}")
    end

    def list_lost_items
      @formatter.list(@item_manager.lost_items, empty_message: 'No lost items found.')
    end

    def list_found_items
      @formatter.list(@item_manager.found_items, empty_message: 'No found items found.')
    end

    def list_returned_items
      @formatter.list(@item_manager.returned_items, empty_message: 'No returned items found.')
    end

    def find_matches
      if @item_manager.found_items.empty?
        @formatter.message('No items found.')
        return
      end

      lost_item = prompt_for_match_item
      return if lost_item.nil?

      criteria = [lost_item.name, lost_item.category, lost_item.location, lost_item.description].reject(&:empty?)
      matches = @item_manager.match_lost_item(lost_item)

      @formatter.message("Matches for: #{criteria.join(' | ')}")
      @formatter.list(matches, empty_message: 'No possible matches found.')
    end

    def prompt_for_match_item
      name = @prompts.ask('Lost item name (optional)')
      return if name.nil?

      category = @prompts.ask('Category (optional)')
      return if category.nil?

      location = @prompts.ask('Location (optional)')
      return if location.nil?

      description = @prompts.ask('Description (optional)')
      return if description.nil?

      criteria = [name, category, location, description].reject(&:empty?)
      if criteria.empty?
        @formatter.error('Enter at least one field to find matches.')
        return
      end

      LostItem.new(name: name, category: category, location: location, description: description)
    end

    def mark_returned
      id = @prompts.ask_id('Lost item ID')
      return if id.nil?

      item = @item_manager.update_status(id, Status::RETURNED)

      if item
        @formatter.message("Item ##{item.id} marked as returned.")
      else
        @formatter.error("No item found with ID #{id}.")
      end
    end

    def help
      @output.puts <<~HELP
        Lost & Found Tracker

        Usage:
          lost_and_found [command]

        Commands:
          add-lost       Report a lost item
          add-found      Report a found item
          list           List all items
          search         Search for items
          match ID       Find possible matches for an item
          return ID      Mark an item as returned
          help            Show this help message

        Options:
          -h, --help      Show this help message

        Examples:
          lost_and_found add-lost
          lost_and_found add-found
          lost_and_found list
          lost_and_found search
          lost_and_found match 1
          lost_and_found return 1
          lost_and_found --help
      HELP
    end
  end
end
