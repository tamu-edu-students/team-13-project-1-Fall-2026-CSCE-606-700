module LostAndFound
  class CLI
    def self.start
      new.run
    end

    def run
      if ARGV.include?("--help") || ARGV.include?("-h")
        help
      else
        puts "Lost & Found Tracker"
        puts "Type './bin/lost_and_found --help' for available commands."
      end
    end

    private

    def help
      puts <<~HELP
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