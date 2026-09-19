require_relative "item"
require_relative "../constants"

class LostItem < Item
  def initialize(date: nil, date_lost: nil, status: Status::LOST, **args)
    super(date: date_lost || date, status: status, **args)
  end

  def date_lost
    date
  end
end
