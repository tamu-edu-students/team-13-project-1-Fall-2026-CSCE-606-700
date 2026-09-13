require_relative "item"

class FoundItem < Item
    def initialize(status: "Found", **args)
        super(status: status, **args)
    end
end
