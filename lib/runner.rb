module Runner
  def seperator_and_text
    puts "-------------------------------------------------"
    yield
    puts "-------------------------------------------------"
  end

  def input_info
    puts "Please input the following information:"
    puts "(if information is unavailible simply hit return)"
  end

  def not_valid
    puts "Invalid Input: ".colorize(:red)
    yield
  end

  def press_return
    puts "Press return to go back to the main menu:".colorize(:green)
  end
end
