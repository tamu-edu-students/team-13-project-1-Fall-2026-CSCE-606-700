require "stringio"
require_relative "../../lib/lost_and_found/ui/prompts"

RSpec.describe Prompts do
  describe "#ask_required" do
    it "re-prompts when a required field is blank" do
      input = StringIO.new("\nBlack Wallet\n")
      output = StringIO.new
      prompts = Prompts.new(input: input, output: output)

      result = prompts.ask_required("Item name")

      expect(result).to eq("Black Wallet")
      expect(output.string).to include("Item name is required.")
    end
  end

  describe "#ask_date" do
    it "re-prompts when the date is invalid" do
      input = StringIO.new("02/30/2026\n09/25/2026\n")
      output = StringIO.new
      prompts = Prompts.new(input: input, output: output)

      result = prompts.ask_date("Date lost")

      expect(result).to eq("09/25/2026")
      expect(output.string).to include("Invalid date. Please use MM/DD/YYYY.")
    end

    it "allows the optional date field to be blank" do
      input = StringIO.new("\n")
      output = StringIO.new
      prompts = Prompts.new(input: input, output: output)

      result = prompts.ask_date("Date found")

      expect(result).to eq("")
    end
  end

  describe "#ask_id" do
    it "re-prompts when the ID is not numeric" do
      input = StringIO.new("abc\n5\n")
      output = StringIO.new
      prompts = Prompts.new(input: input, output: output)

      result = prompts.ask_id("Lost item ID")

      expect(result).to eq(5)
      expect(output.string).to include("Invalid ID. Please enter a number.")
    end
  end
end