module Runner
  def seperator_and_text
    puts "\n-------------------------------------------------"
    yield
    puts "-------------------------------------------------"
  end

  def input_info
    puts "Please input the following information:"
    puts "(if information is unavailible simply hit return)"
  end

  def not_valid
    print "\nInvalid Input: ".colorize(:red)
    yield
    puts
  end

  def press_return
    puts "Press return to go back to the main menu:".colorize(:green)
  end
end
