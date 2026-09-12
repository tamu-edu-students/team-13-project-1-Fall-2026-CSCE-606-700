class Item
  attr_reader :id, :name, :description, :category, :location, :date, :status

  @@next_id = 1

  def initialize(name:, description:, category:, location:, date:, status:)
    @id = @@next_id
    @@next_id += 1

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
end