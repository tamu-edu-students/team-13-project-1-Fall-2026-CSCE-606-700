require "json"
require "fileutils"
require_relative "models/item"
require_relative "models/lost_item"
require_relative "models/found_item"

class ItemManager
    DEFAULT_STORAGE_PATH = File.expand_path("../../data/items.json", __dir__)

    ITEM_TYPES = {
        "LostItem" => LostItem,
        "FoundItem" => FoundItem
    }.freeze

    def initialize(storage_path = DEFAULT_STORAGE_PATH)
        @storage_path = storage_path
        @items = load_items
        @next_id = @items.map(&:id).compact.max.to_i + 1
    end

    def add_item(item)
        item.id = @next_id
        @next_id += 1
        @items << item
        save_items
        item
    end

    def all_items
        @items.dup
    end

    def search_items(filters = {})
        @items.select do |item|
            filters.all? do |field, value|
                next true if value.nil? || value.to_s.strip.empty?

                item.respond_to?(field) && item.public_send(field).to_s.downcase.include?(value.to_s.downcase)
            end
        end
    end

    private

    def load_items
        return [] unless File.exist?(@storage_path)

        content = File.read(@storage_path).strip
        return [] if content.empty?

        JSON.parse(content).map { |record| deserialize(record) }
    rescue JSON::ParserError
        []
    end

    def save_items
        FileUtils.mkdir_p(File.dirname(@storage_path))
        File.write(@storage_path, JSON.pretty_generate(@items.map(&:to_h)))
    end

    def deserialize(record)
        klass = ITEM_TYPES.fetch(record["type"], Item)
        klass.from_h(record)
    end
end
