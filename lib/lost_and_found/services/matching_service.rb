class MatchingService
    def find_matches(lost_item, found_items)
        found_items.select do |found_item|
        score(lost_item, found_item) >= 0.6
        end
    end

    private

    def score(lost_item, found_item)
        # matching algorithm
    end
end