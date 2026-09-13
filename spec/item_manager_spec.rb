require "tmpdir"
require "fileutils"
require "json"
require_relative "../lib/lost_and_found/item_manager"
require_relative "../lib/lost_and_found/models/lost_item"
require_relative "../lib/lost_and_found/models/found_item"

RSpec.describe ItemManager do
    let(:storage_path) { File.join(Dir.mktmpdir, "items.json") }

    after do
        FileUtils.rm_rf(File.dirname(storage_path))
    end

    describe "on first run" do
        it "starts with no items when the data file does not exist" do
            manager = ItemManager.new(storage_path)

            expect(manager.all_items).to eq([])
        end

        it "starts with no items when the data file is empty" do
            FileUtils.mkdir_p(File.dirname(storage_path))
            File.write(storage_path, "")

            manager = ItemManager.new(storage_path)

            expect(manager.all_items).to eq([])
        end
    end

    describe "#add_item" do
        it "assigns a unique id and writes the record to the data file" do
            manager = ItemManager.new(storage_path)
            item = LostItem.new(name: "Black Wallet", location: "Library")

            manager.add_item(item)

            expect(item.id).to eq(1)
            expect(File.exist?(storage_path)).to be(true)

            saved = JSON.parse(File.read(storage_path))
            expect(saved.length).to eq(1)
            expect(saved.first["name"]).to eq("Black Wallet")
            expect(saved.first["type"]).to eq("LostItem")
        end

        it "assigns increasing ids across multiple items" do
            manager = ItemManager.new(storage_path)

            first = manager.add_item(LostItem.new(name: "Black Wallet", location: "Library"))
            second = manager.add_item(FoundItem.new(name: "Car Keys", location: "Gym"))

            expect([first.id, second.id]).to eq([1, 2])
        end
    end

    describe "persistence across instances" do
        it "loads previously saved records on startup" do
            first_manager = ItemManager.new(storage_path)
            first_manager.add_item(LostItem.new(name: "Black Wallet", location: "Library"))
            first_manager.add_item(FoundItem.new(name: "Car Keys", location: "Gym"))

            second_manager = ItemManager.new(storage_path)
            reloaded = second_manager.all_items

            expect(reloaded.map(&:name)).to contain_exactly("Black Wallet", "Car Keys")
            expect(reloaded.map(&:class)).to contain_exactly(LostItem, FoundItem)
        end

        it "continues assigning ids after items already exist in the file" do
            first_manager = ItemManager.new(storage_path)
            first_manager.add_item(LostItem.new(name: "Black Wallet", location: "Library"))

            second_manager = ItemManager.new(storage_path)
            new_item = second_manager.add_item(FoundItem.new(name: "Car Keys", location: "Gym"))

            expect(new_item.id).to eq(2)
        end
    end

    describe "#search_items" do
        it "filters items by a partial, case-insensitive match" do
            manager = ItemManager.new(storage_path)
            manager.add_item(LostItem.new(name: "Black Backpack", location: "Library"))
            manager.add_item(LostItem.new(name: "Car Keys", location: "Gym"))

            results = manager.search_items(name: "backpack")

            expect(results.map(&:name)).to eq(["Black Backpack"])
        end
    end
end
