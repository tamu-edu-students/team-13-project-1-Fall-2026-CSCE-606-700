require_relative "item"
require_relative "../constants"

class LostItem < Item
  attr_reader :date_lost

  def initialize(name:, description:, category:, location:, date_lost:)
    super(
      name: name,
      description: description,
      category: category,
      location: location,
      date: date_lost,
      status: Status::LOST
    )

    @date_lost = date_lost
  end
end