require_relative "../models/item"
require_relative "../models/lost_item"
require_relative "../models/found_item"
require_relative "../storage/database"

class ItemRepository
  ITEM_TYPES = {
    "LostItem" => LostItem,
    "FoundItem" => FoundItem
  }.freeze

  SEARCHABLE_FIELDS = %w[name description category location date status].freeze

  def initialize(connection = Database.connect)
    @connection = connection
  end

  def create(item)
    @connection.execute(
      "INSERT INTO items (type, name, description, category, location, date, status) VALUES (?, ?, ?, ?, ?, ?, ?)",
      [item.class.name, item.name, item.description, item.category, item.location, item.date, item.status]
    )
    item.id = @connection.last_insert_row_id
    item
  end

  def find(id)
    row = @connection.get_first_row("SELECT * FROM items WHERE id = ?", [id])
    row ? deserialize(row) : nil
  end

  def all
    @connection.execute("SELECT * FROM items").map { |row| deserialize(row) }
  end

  def search(filters = {})
    clauses = []
    values = []

    filters.each do |field, value|
      next if value.nil? || value.to_s.strip.empty?

      column = field.to_s
      next unless SEARCHABLE_FIELDS.include?(column)

      clauses << "LOWER(#{column}) LIKE ?"
      values << "%#{value.to_s.downcase}%"
    end

    sql = "SELECT * FROM items"
    sql += " WHERE #{clauses.join(' AND ')}" unless clauses.empty?

    @connection.execute(sql, values).map { |row| deserialize(row) }
  end

  def update(item)
    @connection.execute(
      "UPDATE items SET type = ?, name = ?, description = ?, category = ?, location = ?, date = ?, status = ? WHERE id = ?",
      [item.class.name, item.name, item.description, item.category, item.location, item.date, item.status, item.id]
    )
    item
  end

  def delete(id)
    @connection.execute("DELETE FROM items WHERE id = ?", [id])
  end

  private

  def deserialize(row)
    klass = ITEM_TYPES.fetch(row["type"], Item)
    klass.from_h(row)
  end
end
