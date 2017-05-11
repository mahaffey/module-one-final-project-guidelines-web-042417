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
end
