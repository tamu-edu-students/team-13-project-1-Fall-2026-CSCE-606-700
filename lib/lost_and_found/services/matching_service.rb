# frozen_string_literal: true

class MatchingService
  WEIGHTS = {
    name: 0.4,
    category: 0.2,
    location: 0.2,
    description: 0.2
  }.freeze

  THRESHOLD = 0.6

  def find_matches(lost_item, found_items)
    found_items.select do |found_item|
      score(lost_item, found_item) >= THRESHOLD
    end
  end

  private

  def score(lost_item, found_item)
    fields = WEIGHTS.reject { |field, _weight| normalize(lost_item.public_send(field)).empty? }
    return 0.0 if fields.empty?

    total_weight = fields.values.sum
    fields.sum do |field, weight|
      weight * field_score(lost_item.public_send(field), found_item.public_send(field))
    end / total_weight
  end

  # Exact match scores highest, one value containing the other scores partial
  # credit, and otherwise similarity falls back to shared-word overlap so
  # close-but-not-identical text (e.g. slightly different descriptions)
  # still contributes to the score instead of being treated as unrelated.
  def field_score(left, right)
    left = normalize(left)
    right = normalize(right)
    return 0.0 if left.empty? || right.empty?
    return 1.0 if left == right
    return 0.7 if left.include?(right) || right.include?(left)

    word_overlap(left, right)
  end

  def word_overlap(left, right)
    words_left = left.split(/\W+/).reject(&:empty?)
    words_right = right.split(/\W+/).reject(&:empty?)
    return 0.0 if words_left.empty? || words_right.empty?

    shared = (words_left & words_right).size.to_f
    total = (words_left | words_right).size
    shared / total
  end

  def normalize(value)
    value.to_s.strip.downcase
  end
end
