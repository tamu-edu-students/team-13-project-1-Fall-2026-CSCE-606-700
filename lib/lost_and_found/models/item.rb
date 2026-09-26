# frozen_string_literal: true

class Item
  attr_accessor :id, :status
  attr_reader :name, :description, :category, :location, :date

  def initialize(name:, location:, id: nil, description: nil, category: nil, date: nil, status: nil)
    @id = id
    @name = name
    @description = description
    @category = category
    @location = location
    @date = date
    @status = status
  end

  def to_s
    "ID: #{@id} | #{@name} | #{@category} | #{@location} | #{@date} | #{@status}"
  end

  def to_h
    {
      'type' => self.class.name,
      'id' => id,
      'name' => name,
      'description' => description,
      'category' => category,
      'location' => location,
      'date' => date,
      'status' => status
    }
  end

  def self.from_h(hash)
    new(
      id: hash['id'],
      name: hash['name'],
      description: hash['description'],
      category: hash['category'],
      location: hash['location'],
      date: hash['date'],
      status: hash['status']
    )
  end
end
