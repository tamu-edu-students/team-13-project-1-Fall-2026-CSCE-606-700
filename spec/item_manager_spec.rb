require "tmpdir"
require "fileutils"
require_relative "../lib/lost_and_found/item_manager"
require_relative "../lib/lost_and_found/repositories/item_repository"
require_relative "../lib/lost_and_found/storage/database"
require_relative "../lib/lost_and_found/models/lost_item"
require_relative "../lib/lost_and_found/models/found_item"

RSpec.describe ItemManager do
  let(:db_path) { File.join(Dir.mktmpdir, "items.sqlite3") }

  after do
    FileUtils.rm_rf(File.dirname(db_path))
  end

  def build_manager
    ItemManager.new(ItemRepository.new(Database.connect(db_path)))
  end

  describe "on first run" do
    it "starts with no items when the database file does not exist yet" do
      manager = build_manager

      expect(manager.all_items).to eq([])
    end
  end

  describe "#add_item" do
    it "assigns a unique id and writes the record to the database" do
      manager = build_manager
      item = LostItem.new(name: "Black Wallet", location: "Library")

      manager.add_item(item)

      expect(item.id).not_to be_nil
      expect(manager.all_items.map(&:name)).to eq(["Black Wallet"])
    end
  end

  describe "persistence across instances" do
    it "loads previously saved records on startup" do
      build_manager.add_item(LostItem.new(name: "Black Wallet", location: "Library"))
      build_manager.add_item(FoundItem.new(name: "Car Keys", location: "Gym"))

      reloaded = build_manager.all_items

      expect(reloaded.map(&:name)).to contain_exactly("Black Wallet", "Car Keys")
      expect(reloaded.map(&:class)).to contain_exactly(LostItem, FoundItem)
    end
  end

  describe "#search_items" do
    it "filters items by a partial, case-insensitive match" do
      manager = build_manager
      manager.add_item(LostItem.new(name: "Black Backpack", location: "Library"))
      manager.add_item(LostItem.new(name: "Car Keys", location: "Gym"))

      results = manager.search_items(name: "backpack")

      expect(results.map(&:name)).to eq(["Black Backpack"])
    end
    it "searches items by category" do
      manager = build_manager

      manager.add_item(
        LostItem.new(
          name: "Black Wallet",
          category: "Wallet",
          location: "Library"
        )
      )

      manager.add_item(
        LostItem.new(
          name: "Car Keys",
          category: "Keys",
          location: "Gym"
        )
      )

      results = manager.search_items(category: "wallet")

      expect(results.map(&:name)).to eq(["Black Wallet"])
    end

    it "searches items by location" do
      manager = build_manager

      manager.add_item(
        LostItem.new(
          name: "Black Wallet",
          category: "Wallet",
          location: "Evans Library"
        )
      )

      manager.add_item(
        LostItem.new(
          name: "Car Keys",
          category: "Keys",
          location: "Gym"
        )
      )

      results = manager.search_items(location: "library")

      expect(results.map(&:name)).to eq(["Black Wallet"])
    end
  end
end
