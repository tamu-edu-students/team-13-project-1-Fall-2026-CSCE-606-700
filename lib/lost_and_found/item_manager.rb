class ItemManager
    def initialize(repository)
        @repository = repository
    end

    def add_item(item)
        @repository.create(item)
    end

    def search_items(filters)
        @repository.search(filters)
    end
end