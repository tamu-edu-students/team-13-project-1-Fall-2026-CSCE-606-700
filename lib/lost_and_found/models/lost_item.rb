require_relative "item"

class LostItem < Item
  attr_reader :date_lost

  def initialize(name:, description:, category:, location:, date_lost:)
    super(
      name: name,
      description: description,
      category: category,
      location: location,
      date: date_lost,
      status: "Lost"
    )

    @date_lost = date_lost
  end
end