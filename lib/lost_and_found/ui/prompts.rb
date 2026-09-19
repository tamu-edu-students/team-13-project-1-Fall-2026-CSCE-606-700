class Prompts
  MENU = <<~MENU
    1. Add a lost item
    2. Add a found item
    3. List / search items
    4. Find matches for a lost item
    5. Mark an item as returned
    6. Quit
  MENU

  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
  end

  def show_menu
    @output.puts
    @output.puts MENU
    @output.print "Choose an option: "
  end

  def read_choice
    line = @input.gets
    line&.strip
  end

  def ask(label)
    @output.print "#{label}: "
    line = @input.gets
    line&.strip
  end

  # Re-prompts on a blank answer; returns nil only when input has run out (EOF).
  def ask_required(label)
    loop do
      value = ask(label)
      return nil if value.nil?
      return value unless value.empty?

      @output.puts "#{label} is required."
    end
  end
end
