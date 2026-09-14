require "tmpdir"
require "fileutils"
require_relative "../../lib/lost_and_found/repositories/item_repository"
require_relative "../../lib/lost_and_found/storage/database"
require_relative "../../lib/lost_and_found/models/lost_item"
require_relative "../../lib/lost_and_found/models/found_item"

RSpec.describe ItemRepository do
    let(:db_path) { File.join(Dir.mktmpdir, "items.sqlite3") }

    after do
        FileUtils.rm_rf(File.dirname(db_path))
    end

    def build_repository
        ItemRepository.new(Database.connect(db_path))
    end

    describe "on first run" do
        it "starts with no items when the database file does not exist yet" do
            repository = build_repository

            expect(repository.all).to eq([])
        end
    end

    describe "#create" do
        it "assigns a unique id and persists the record" do
            repository = build_repository
            item = LostItem.new(name: "Black Wallet", location: "Library")

            repository.create(item)

            expect(item.id).not_to be_nil
            expect(repository.all.map(&:name)).to eq(["Black Wallet"])
        end

        it "assigns increasing ids across multiple items" do
            repository = build_repository

            first = repository.create(LostItem.new(name: "Black Wallet", location: "Library"))
            second = repository.create(FoundItem.new(name: "Car Keys", location: "Gym"))

            expect(second.id).to be > first.id
        end
    end

    describe "persistence across connections" do
        it "loads previously saved records from the database file" do
            build_repository.create(LostItem.new(name: "Black Wallet", location: "Library"))
            build_repository.create(FoundItem.new(name: "Car Keys", location: "Gym"))

            reloaded = build_repository.all

            expect(reloaded.map(&:name)).to contain_exactly("Black Wallet", "Car Keys")
            expect(reloaded.map(&:class)).to contain_exactly(LostItem, FoundItem)
        end
    end

    describe "#find" do
        it "returns the item with the given id" do
            repository = build_repository
            created = repository.create(LostItem.new(name: "Black Wallet", location: "Library"))

            found = repository.find(created.id)

            expect(found.name).to eq("Black Wallet")
        end

        it "returns nil when no item has that id" do
            repository = build_repository

            expect(repository.find(999)).to be_nil
        end
    end

    describe "#search" do
        it "filters items by a partial, case-insensitive match" do
            repository = build_repository
            repository.create(LostItem.new(name: "Black Backpack", location: "Library"))
            repository.create(LostItem.new(name: "Car Keys", location: "Gym"))

            results = repository.search(name: "backpack")

            expect(results.map(&:name)).to eq(["Black Backpack"])
        end

        it "returns all items when no filters are given" do
            repository = build_repository
            repository.create(LostItem.new(name: "Black Backpack", location: "Library"))
            repository.create(LostItem.new(name: "Car Keys", location: "Gym"))

            expect(repository.search.length).to eq(2)
        end
    end

    describe "#update" do
        it "persists changes to an existing item" do
            repository = build_repository
            item = repository.create(LostItem.new(name: "Black Wallet", location: "Library"))

            item.status = "Returned"
            repository.update(item)

            expect(repository.find(item.id).status).to eq("Returned")
        end
    end

    describe "#delete" do
        it "removes the item from the database" do
            repository = build_repository
            item = repository.create(LostItem.new(name: "Black Wallet", location: "Library"))

            repository.delete(item.id)

            expect(repository.find(item.id)).to be_nil
        end
    end
end
