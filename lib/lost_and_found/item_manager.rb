# frozen_string_literal: true

require_relative 'constants'
require_relative 'repositories/item_repository'
require_relative 'services/matching_service'

class ItemManager
  def initialize(repository = ItemRepository.new, matching_service: MatchingService.new)
    @repository = repository
    @matching_service = matching_service
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

  # Find possible matches for one lost item. Returns nil if the id does not
  # exist or no longer refers to an open (still Lost) item.
  def match_item(id)
    lost_item = @repository.find(id)
    return nil if lost_item.nil? || lost_item.status != Status::LOST

    @matching_service.find_matches(lost_item, found_items)
  end

  # Find possible matches for a lost-item description that has not been saved.
  def match_lost_item(lost_item)
    @matching_service.find_matches(lost_item, found_items)
  end

  # Find possible matches for every open lost item. Returns a Hash of
  # { lost_item => matching found_items }.
  def match_all_lost_items
    lost_items.each_with_object({}) do |lost_item, matches|
      matches[lost_item] = @matching_service.find_matches(lost_item, found_items)
    end
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
