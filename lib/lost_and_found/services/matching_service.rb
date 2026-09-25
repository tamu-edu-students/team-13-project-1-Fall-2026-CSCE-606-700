require_relative "../models/lost_item"
require_relative "../models/found_item"

class MatchingService
  MATCH_THRESHOLD = 0.6

  def find_matches(lost_item, found_items)
    return [] unless lost_item.is_a?(LostItem)

    found_items = found_items.select do |item|
      item.is_a?(FoundItem)
    end

    found_items
      .map do |found_item|
        {
          item: found_item,
          score: score(lost_item, found_item)
        }
      end
      .select { |match| match[:score] >= MATCH_THRESHOLD }
      .sort_by { |match| -match[:score] }
  end

  private

  def score(lost_item, found_item)
    matches = 0

    matches += 1 if similar?(lost_item.name, found_item.name)
    matches += 1 if similar?(lost_item.category, found_item.category)
    matches += 1 if similar?(lost_item.description, found_item.description)
    matches += 1 if similar?(lost_item.location, found_item.location)

    matches / 4.0
  end

  def similar?(first, second)
    first_text = normalize(first)
    second_text = normalize(second)

    return false if first_text.empty? || second_text.empty?

    first_text.include?(second_text) || second_text.include?(first_text)
  end

  def normalize(value)
    value.to_s.strip.downcase
  end
end