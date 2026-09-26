# frozen_string_literal: true

require_relative 'item'
require_relative '../constants'

class FoundItem < Item
  def initialize(date: nil, date_found: nil, status: Status::FOUND, **args)
    super(date: date_found || date, status: status, **args)
  end

  def date_found
    date
  end
end
