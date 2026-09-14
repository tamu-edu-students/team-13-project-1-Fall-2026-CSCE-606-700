require_relative "repositories/item_repository"

class ItemManager
    def initialize(repository = ItemRepository.new)
        @repository = repository
    end

    def add_item(item)
        @repository.create(item)
    end

    def all_items
        @repository.all
    end

    def search_items(filters = {})
        @repository.search(filters)
    end
end
