class Item
  attr_reader :id, :name, :description, :category, :location, :date
  attr_accessor :status

  def initialize(name:, location:, id: nil, description: nil, category: nil, date: nil, status: nil)
    @id = id
    @name = name
    @description = description
    @category = category
    @location = location
    @date = date
    @status = status
  end

  def id=(new_id)
    @id = new_id
  end

  def to_s
    "ID: #{@id} | #{@name} | #{@category} | #{@location} | #{@date} | #{@status}"
  end

  def to_h
    {
      "type" => self.class.name,
      "id" => id,
      "name" => name,
      "description" => description,
      "category" => category,
      "location" => location,
      "date" => date,
      "status" => status
    }
  end

  def self.from_h(hash)
    new(
      id: hash["id"],
      name: hash["name"],
      description: hash["description"],
      category: hash["category"],
      location: hash["location"],
      date: hash["date"],
      status: hash["status"]
    )
  end
end
