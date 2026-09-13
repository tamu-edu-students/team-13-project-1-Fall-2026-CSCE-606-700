require_relative "item"

class LostItem < Item
    def initialize(status: "Lost", **args)
        super(status: status, **args)
    end
end
