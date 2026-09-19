require "open3"

RSpec.describe "Lost & Found CLI" do
  let(:app) { File.expand_path("../bin/lost_and_found", __dir__) }

  describe "launching the application" do
    it "launches the terminal with a welcome message" do
      output = `#{app}`

      expect(output).to include("Lost & Found Tracker")
      expect(output).to include(
        "Type './bin/lost_and_found --help' for available commands."
      )
    end
  end

  describe "--help" do
    it "displays all available commands" do
      output = `#{app} --help`

      expect(output).to include("Lost & Found Tracker")
      expect(output).to include("Usage:")
      expect(output).to include("add-lost")
      expect(output).to include("add-found")
      expect(output).to include("list")
      expect(output).to include("search")
      expect(output).to include("match ID")
      expect(output).to include("return ID")
      expect(output).to include("help")
      expect(output).to include("-h, --help")
    end
  end
end