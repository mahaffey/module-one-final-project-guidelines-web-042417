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
    trip_creation_output
    gets.strip
    options
  end

  def trip_creation_output
    puts "Trip number: #{new_trip.id}."
    puts "Driver: #{new_trip.driver.name}"
    puts "Vehicle: #{new_trip.vehicle.color} #{new_trip.vehicle.make} #{new_trip.vehicle.model}"
    seperator_and_text {puts "Press return to go back to the main menu:"}
  end

  def seperator_and_text
    puts "-------------------------------------------------"
    yield
    puts "-------------------------------------------------"
  end


  #refactored with seperator_and_text - delete
  # def please_input_info
  #   puts "-------------------------------------------------"
  #   puts "Please input the following information:"
  #   puts "(if information is unavailible simply hit return)"
  #   puts "-------------------------------------------------"
  # end

  def get_client_attributes(name)
    attributes = {first_name: name[0], last_name: name[1],
                  company: "Client company" , phone: "Clients phone number", email: "Client's email address",
                  address: "Clients home address" }

    seperator_and_text {puts "Please input the following information:"
                        puts "(if information is unavailible simply hit return)"}

    attributes.drop(2).collect do |key, value|
      puts "#{value}:"
      attributes[key] = gets.strip
    end

    attributes
  end



  def get_trip_attributes
    attributes = {num_of_pass: "How many passengers", pickup_time: "Pick up time", pickup_loc: "Pick up address: (Street, Zip)", dropoff_loc: "Drop off address: (Street, Zip)"}

    seperator_and_text {puts "Please input the following information:"
                        puts "(if information is unavailible simply hit return)"}

    attributes.collect do |key, value|
      puts "#{value}:"
      attributes[key] = gets.strip
    end


    #refactor example - delete
    # puts "How many passengers:"
    # attributes[:num_of_pass] = gets.strip.to_i
    # puts "Pick up time:"
    # attributes[:pickup_time] = gets.strip
    # puts "Pick up address: (Street, Zip)"
    # attributes[:pickup_loc] = gets.strip
    # puts "Drop off address: (Street, Zip)"
    # attributes[:dropoff_loc] = gets.strip

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

    #directions = GoogleDirections.new(origin, destination)
    #drive_time_in_minutes = directions.drive_time_in_minutes
    #distance_in_miles = directions.distance_in_miles
    #directions.methods
    #directions.distance = meters
    #directions.distance_text.split(" ")[0].to_f
      # create driver (create)
        # request driver
      # create vehicle (create)
        # request vehicle
          #attributes???

end
