class Formatter
  def initialize(output: $stdout)
    @output = output
  end

  def list(items, empty_message: "No items found.")
    if items.nil? || items.empty?
      @output.puts empty_message
    else
      items.each { |item| @output.puts item.to_s }
    end
  end

  def item(single_item, missing_message: "Item not found.")
    if single_item
      @output.puts single_item.to_s
    else
      @output.puts missing_message
    end
  end

  def message(text)
    @output.puts text
  end

  def error(text)
    @output.puts "Error: #{text}"
  end
end
