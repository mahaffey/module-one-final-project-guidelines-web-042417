class CLI
  #1 welcome
  def welcome
    puts "Welcome to the cabbie dispatch app 0.1"
    options
  end

  def options
    puts "What would you like to do? (select 1-3)"
    puts "1. Schedule a new trip"
    puts "2. Modify an existing trip"
    puts "3. Quit"

    case gets.strip
    when "1"
      schedule_new_trip
    when "2"
      #modify_existing_trip
    when "3"
      exit
    else
      puts "Invalid Input: Please Enter 1-3"
      options
    end
  end

  def schedule_new_trip
    puts "Enter client full name:"
    name = gets.strip.split(" ")

    client = Client.find_by({first_name: name[0], last_name: name[1]})

    client = Client.create(get_client_attributes(name)) if client == nil
    new_trip = Trip.create(get_trip_attributes)
    new_trip.client = client
    new_trip.driver = Driver.all.sample
    new_trip.vehicle = Vehicle.all.sample
    puts "Trip number: #{new_trip.id}."
    puts "Driver: #{new_trip.driver.name}"
    puts "Vehicle: #{new_trip.vehicle.color} #{new_trip.vehicle.make} #{new_trip.vehicle.model}"
    puts "-------------------------------------------------"
    puts "Press return to go back to the main menu:"
    puts "-------------------------------------------------"
    gets.strip
    options
  end

  def please_input_info
    puts "-------------------------------------------------"
    puts "Please input the following information:"
    puts "(if information is unavailible simply hit return)"
    puts "-------------------------------------------------"
  end

  def get_client_attributes(name)
    attributes = {first_name: name[0], last_name: name[1], company: nil, phone: nil, email: nil, address: nil }
    please_input_info
    puts "Client company:"
    attributes[:company] = gets.strip
    puts "Client phone number:"
    attributes[:phone] = gets.strip
    puts "Client email address:"
    attributes[:email] = gets.strip
    puts "Client address:"
    attributes[:address] = gets.strip
    attributes
  end

  def get_trip_attributes
    attributes = {price: nil, miles: nil, num_of_pass: nil, pickup_time: nil, pickup_loc: nil, dropoff_loc: nil}
    please_input_info
    puts "How many passengers:"
    attributes[:num_of_pass] = gets.strip.to_i
    puts "Pick up time:"
    attributes[:pickup_time] = gets.strip
    puts "Pick up address: (Street, Zip)"
    attributes[:pickup_loc] = gets.strip
    puts "Drop off address: (Street, Zip)"
    attributes[:dropoff_loc] = gets.strip
    attributes[:price] = rand(45..100)
    attributes[:miles] = rand(1..25)
    attributes
  end

  #2 Options
    # Schedule a trip (create)
      #insert from 3
    # 7 Modify a trip (update)
    # 8 Quit App

    #3 create/retrieve client by name
      #if client does not exist
        #4 get client attributes
          #5a create client
      # if client exists
        #5b find client by name

      #6 initialize create a trip with found/created client
      #6.5 give user trip ID

    # ---- COMING SOON TO AN APP NEAR YOU -----
      # create driver (create)
        # request driver
      # create vehicle (create)
        # request vehicle
          #attributes???

end
