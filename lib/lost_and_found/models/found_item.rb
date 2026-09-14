require_relative "item"
require_relative "../constants"

class FoundItem < Item
  attr_reader :date_found

  def initialize(name:, description:, category:, location:, date_found:)
    super(
      name: name,
      description: description,
      category: category,
      location: location,
      date: date_found,
      status: Status::FOUND
    )

    @date_found = date_found
  end
end