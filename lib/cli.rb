class CLI
  include Runner

  def welcome
    system("clear")
    puts "Welcome to the cabbie dispatch app 0.2".colorize(:yellow)
    main_menu
  end

  def main_menu
    @trip_switch = 0
    #controls return of options 1 - 2 on creating client and scheduling trip
    seperator_and_text{puts "What would you like to do? (select 1-7)".colorize(:green)}
    puts "1. Create new client"
    puts "2. Schedule a new trip"
    puts "3. Update or View an existing trip"
    puts "4. Add new driver to database"
    puts "5. Add new vehicle to database"
    puts "6. View information"
    puts "7. Quit"

    case gets.strip
    when "1"
      client_check
    when "2"
      schedule_new_trip
    when "3"
      seperator_and_text {puts "Enter the trip ID:".colorize(:green)}
      @trip_id = gets.strip.to_i
      update_or_view_existing_trip
    when "4"
      driver_prompt
    when "5"
      vehicle_prompt
    when "6"
      list_menu
    when "7"
      exit
    else
      not_valid {print "Please Enter 1-7".colorize(:red)}
      main_menu
    end
  end

  def list_menu
    seperator_and_text{puts "What would you like to list? (select 1-5)".colorize(:green)}
    puts "1. List all trips"
    puts "2. List all clients"
    puts "3. List all drivers"
    puts "4. List all vehicles"
    puts "5. Go back to main_menu"

    case gets.strip
    when "1"
      list(Trip)
    when "2"
      list(Client)
    when "3"
      list(Driver)
    when "4"
      list(Vehicle)
    when "5"
      main_menu
    else
      not_valid {print "Please Enter 1-5".colorize(:red)}
      list_menu
    end
  end

  def list(this_class)
    this_class.all.each do |item|
      if this_class == Trip
        view_trip_template(item)
      elsif this_class == Client
        view_client_template(item)
      elsif this_class == Driver
         view_drivers_template(item)
      elsif this_class == Vehicle
        view_vehicles_template(item)
      end
    end
    seperator_and_text {puts "Press return to go back to the main menu:".colorize(:green)}
    gets.strip
    main_menu
  end

  #when 1 or 2 check client when creating a client of trip
  def client_check
    puts "Enter client full name:".colorize(:green)
    name = gets.strip.split(" ")
    client = Client.find_by({first_name: name[0], last_name: name[1]})
    if client
      puts "This client already exists. Their client id is #{client.id}.".colorize(:green)
      main_menu if @trip_switch == 0
      client
    else
      client_prompt(name)
    end
  end

  def client_prompt(name)
      seperator_and_text{puts "Client not found in database.".colorize(:yellow)
                         input_info}
      client_new = get_client_attributes_and_create(name)
      puts "A new client has been added to your database".colorize(:green)
      puts "New Client ID: #{client_new.id}"
      puts "Client name: #{name}"
      if @trip_switch == 0
        seperator_and_text {press_return}
        gets.strip
        main_menu
      end
      client_new
  end

  #when 1 or 2, when client doesn't exist client, client is created
  def get_client_attributes_and_create(name)
      attributes = {first_name: name[0], last_name: name[1],
                    company: "Client's company" , phone: "Client's phone number", email: "Client's email address",
                    address: "Client's home address" }

      attributes.drop(2).collect do |key, value|
        puts "#{value}:"
        attributes[key] = gets.strip
      end
      Client.create(attributes)
  end

  def schedule_new_trip
    @trip_switch = 1
    client = client_check
    new_trip = get_trip_attributes_and_create
    new_trip.update(client: client)
    trip_creation_output(new_trip)
    seperator_and_text {puts "To add driver or vehicle now select 'Update or View an existing trip' from the main menu then choose to 'Update an existing trip'"
    press_return}
    gets.strip
    main_menu
  end

  def get_trip_attributes_and_create
    attributes = {num_of_pass: "How many passengers", pickup_time: "Please input date and time in the following format(24 hour time): YYYY-MM-DD-HH-mm", pickup_loc: "Pick up address/location", dropoff_loc: "Drop off address/location"}

    seperator_and_text {input_info}

    attributes.collect do |key, value|
      puts "#{value}:"
      if key == :pickup_time
        input = time_array
      elsif key == :age || key == :experience || key == :lic_number
        input = gets.strip
        while input.to_i == 0
          puts "Please input an integer:".colorize(:red)
          input = gets.strip
        end
      else
        input = gets.strip
      end
      attributes[key] = input
    end
    Trip.create(attributes)
  end

  def time_array
    dt_array = gets.strip.split("-")
    alpha = ("a".."z").to_a
    dt_array.each do |n|
      if n.split("").any? { |x| alpha.include?(x) }
        puts "Input valid time:".colorize(:red)
        time_array
      end
    end
    dt_array = dt_array.collect { |n| n.to_i }
    Time.utc(*dt_array)
  end

  def trip_creation_output(new_trip)
    puts "Trip number: #{new_trip.id}".colorize(:green)
    seperator_and_text {puts "Trip Details"}
    if new_trip.num_of_pass > 2
      x = "and #{new_trip.num_of_pass - 1} friends "
    elsif new_trip.num_of_pass = 2
      x = "and 1 friend "
    else
      x = ""
    end
    puts "Taking #{new_trip.client.first_name} #{x}from #{new_trip.pickup_loc} to #{new_trip.dropoff_loc}."
    puts "Your trip should take approximately #{new_trip.estimated_time_minutes} minutes. This should get you to your destination around #{new_trip.dropoff_time.hour}:#{new_trip.dropoff_time.min}"
  end

  #when 3, update or view existing trip
  def update_or_view_existing_trip
     seperator_and_text {puts "What would you like to do? (select 1-3)"
                         puts "1. Update an existing trip"
                         puts "2. View an existing trip"
                         puts "3. Back to main menu"}
     case gets.strip
     when "1"
       update_trip
     when "2"
       view_trip_template(Trip.find(@trip_id))
       update_or_view_existing_trip
     when "3"
       main_menu
     else
       puts "Invalid Input: Please Enter 1-3".colorize(:red)
       update_or_view_existing_trip
     end
  end

  def update_trip
     key = nil
     puts "What would you like to update? (select 1-7)"
     puts "1. Number of Passengers"
     puts "2. Pickup Time"
     puts "3. Pickup Location"
     puts "4. Dropoff Location"
     puts "5. Add/Change Driver"
     puts "6. Add/Change Vehicle"
     puts "7. Go Back"
     case gets.strip
     when "1"
      key = :num_of_pass
      puts "Enter New Value:"
      val = gets.strip
     when "2"
      key = :pickup_time
      puts "Enter New Value:"
      val = time_array
     when "3"
      key = :pickup_loc
      puts "Enter New Value:"
      val = gets.strip
     when "4"
      key = :dropoff_loc
      puts "Enter New Value:"
      val = gets.strip
     when "5"
      key = :driver
      puts "Enter Name of Driver"
      input = gets.strip
      val = Driver.find_by_name(input)
     when "6"
       key = :vehicle
       puts "Enter Vehicle ID"
       input = gets.strip.to_i
       val = Vehicle.find(input)
     when "7"
      update_or_view_existing_trip
     else
      puts "Invalid Input: Please Enter 1-5".colorize(:red)
      update_trip
     end
     Trip.all.where("ID = #{@trip_id}").update(key => val)
     do_you_want_to_continue_updating_trip
  end

  def do_you_want_to_continue_updating_trip
    puts "Would you like to update another value? y/n?"
    case gets.strip
    when "y" || "Y"
      update_trip
    when "n" || "N"
      main_menu
    else
      puts "Invalid Input: Please Enter y or n".colorize(:red)
      do_you_want_to_continue_updating_trip
    end
  end

  #when 4, add a new driver to the database
  def driver_prompt
    puts "Enter new driver's information:"
    new_driver = get_driver_attributes_and_create
    puts "A new driver has been created"
    puts "New Driver ID: #{new_driver.id}"
    puts "Driver name: #{new_driver.name}"
    seperator_and_text {press_return}
    gets.strip
    main_menu
  end

  def get_driver_attributes_and_create
    attributes = {
      name: "Name of driver", age: "Age of driver",
      experience: "Years of experience driving",
      phone: "Driver's phone number", email: "Driver's email address",
      address: "Driver's home address", lic_state: "License state",
      lic_number: "License number", lic_class: "License class"
    }

    seperator_and_text {input_info}

    attributes.collect do |key, value|
      puts "#{value}:"
      input = gets.strip
      if key == :age || key == :experience || key == :lic_number
        while input.to_i == 0
          puts "Please input an integer:".colorize(:red)
          input = gets.strip
        end
      end
      attributes[key] = input
    end
    Driver.create(attributes)
  end

  #when 5, add a new vehicle to the database
  def vehicle_prompt
    puts "Enter new vehicle's information:"
    vehicle_new = get_vehicle_attributes_and_create
    puts "A new vehicle has been added to the garage"
    puts "New Vehicle ID: #{vehicle_new.id}"
    seperator_and_text {press_return}
    gets.strip
    main_menu
  end

  def get_vehicle_attributes_and_create
    attributes = {
      lic_plate: "License plate number", year: "Year of vehicle",
      make: "Make", model: "Model", color: "Color",
      seats: "How many seats", mileage: "Current mileage",
      type_of_veh: "Type of vehicle", veh_class: "License class required to drive"
    }

    seperator_and_text {input_info}

    attributes.collect do |key, value|
      puts "#{value}:"
      input = gets.strip
      if key == :year || key == :mileage || key == :seats
        while input.to_i == 0
          puts "Please input an integer:".colorize(:red)
          input = gets.strip
        end
      end
      attributes[key] = input
    end
    Vehicle.create(attributes)
 end

  #when 6, list all of the trips in the database
  def list_trips
    Trip.all.each do |trip|
      view_trip_template(trip)
    end
    seperator_and_text {press_return}
    gets.strip
    main_menu
  end

 def update_trip
    key = nil
    puts "What would you like to update? (select 1-5)"
    puts "1. Number of Passengers"
    puts "2. Pickup Time"
    puts "3. Pickup Location"
    puts "4. Dropoff Location"
    puts "5. Add/Change Driver"
    puts "6. Add/Change Vehicle"
    puts "7. Go Back"
    case gets.strip
    when "1"
     key = :num_of_pass
     puts "Enter New Value:"
     val = gets.strip
    when "2"
     key = :pickup_time
     puts "Enter New Value:"
     val = time_array
    when "3"
     key = :pickup_loc
     puts "Enter New Value:"
     val = gets.strip
    when "4"
     key = :dropoff_loc
     puts "Enter New Value:"
     val = gets.strip
    when "5"
     key = :driver
     puts "Enter Name of Driver"
     input = gets.strip
     val = Driver.find_by_name(input)
    when "6"
      key = :vehicle
      puts "Enter Vehicle ID"
      input = gets.strip.to_i
      val = Vehicle.find(input)
   when "7"
     update_or_view_existing_trip
   else
     not_valid {print "Please Enter 1-5"}
     update_trip
   end
   Trip.find(@trip_id).update(key => val)
   do_you_want_to_continue_updating_trip
 end

  def view_trip_template(trip)
    seperator_and_text {puts "Trip Details (Trip ID: #{trip.id})".colorize(:green)}
    puts "Driver Name: #{trip.driver.name}" if trip.driver
    puts "Vehicle Type: #{trip.vehicle.year} #{trip.vehicle.make} #{trip.vehicle.model}" if trip.vehicle
    puts "Client Name: #{trip.client.first_name} #{trip.client.last_name}"
    puts "Price: #{trip.price_string}"
    puts "Miles: #{trip.miles}"
    puts "Number of Passengers: #{trip.num_of_pass}"
    puts "Pick-Up Time: #{trip.pickup_time}"
    puts "Pick-Up Location: #{trip.pickup_loc}"
    puts "Drop-Off Time: #{trip.dropoff_time}"
    puts "Drop-off Location: #{trip.dropoff_loc}"
  end

  #when 7, list all of the clients in the database
  def list_clients
    Client.all.each do |client|
      view_client_template(client)
    end
    seperator_and_text {press_return}
    gets.strip
    main_menu
  end


 def do_you_want_to_continue_updating_trip
   puts "Would you like to update another value? y/n?"
   case gets.strip
   when "y" || "Y"
     update_trip
   when "n" || "N"
     main_menu
   else
     not_valid {print "Please Enter y or n"}
     do_you_want_to_continue_updating_trip
   end
 end

  def view_client_template(client)
   seperator_and_text {puts "Client Details (Client ID: #{client.id})".colorize(:green)}
   puts "Name: #{client.first_name} #{client.last_name}"
   puts "Company: #{client.company}" if client.company
   puts "Phone Number: #{client.phone}"
   puts "Email Address: #{client.email}"
   puts "Home Address: #{client.address}"
  end

  #when 8, list all of the drivers in the database
  def list_drivers
    Driver.all.each do |driver|
      view_drivers_template(driver)
    end
    seperator_and_text {puts "Press return to go back to the main menu:".colorize(:green)}
    gets.strip
    main_menu
  end

  def view_drivers_template(driver)
   seperator_and_text {puts "Driver Details (Driver ID: #{driver.id})".colorize(:green)}
   puts "Name: #{driver.name}"
   puts "Age: #{driver.age}"
   puts "Years of Experience: #{driver.experience}"
   puts "Phone Number: #{driver.phone}"
   puts "Email Address: #{driver.email}"
   puts "Home Address: #{driver.address}"
   puts "License State: #{driver.lic_state}"
   puts "License Number: #{driver.lic_number}"
   puts "License Class: #{driver.lic_class}"
  end

  #when 9, list all of the vehicles in the database
  def list_vehicles
    Vehicle.all.each do |vehicle|
      view_vehicles_template(vehicle)
    end
    seperator_and_text {puts "Press return to go back to the main menu:".colorize(:green)}
    gets.strip
    main_menu
  end

  def view_vehicles_template(vehicle)
   seperator_and_text {puts "Vehicle Details (Vehicle ID: #{vehicle.id})".colorize(:green)}
   puts "License Plate Number: #{vehicle.lic_plate}"
   puts "Year: #{vehicle.year}"
   puts "Make: #{vehicle.make}"
   puts "Model: #{vehicle.model}"
   puts "Color: #{vehicle.color}"
   puts "Number of Seats: #{vehicle.seats}"
   puts "Current Mileage: #{vehicle.mileage}"
   puts "Type: #{vehicle.type_of_veh}"
   puts "Class: #{vehicle.veh_class}"
 end


end
