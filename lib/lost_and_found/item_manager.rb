# frozen_string_literal: true

require_relative 'constants'
require_relative 'repositories/item_repository'

class ItemManager
  def initialize(repository = ItemRepository.new)
    @repository = repository
  end

  # Add lost or found records
  def add_item(item)
    @repository.create(item)
  end

  # Retrieve all items
  def all_items
    @repository.all
  end

  # Retrieve one item by ID
  def find_item(id)
    @repository.find(id)
  end

  # Retrieve lost items only
  def lost_items
    @repository.all.select do |item|
      item.status == Status::LOST
    end
  end

  # Retrieve found items only
  def found_items
    @repository.all.select do |item|
      item.status == Status::FOUND
    end
  end

  # Retrieve returned items only
  def returned_items
    @repository.all.select do |item|
      item.status == Status::RETURNED
    end
  end

  # Search entry point
  def search_items(filters = {})
    @repository.search(filters)
  end

  # Match entry point
  # Actual matching logic will be implemented in the matching feature task
  def match_item(id)
    @repository.find(id)
  end

  # Update item status
  def update_status(id, new_status)
    item = @repository.find(id)
    return nil if item.nil?

    item.status = new_status
    @repository.update(item)

    item
  end
end
