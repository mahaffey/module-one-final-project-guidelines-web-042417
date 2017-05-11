class CLI
  def welcome
    puts "Welcome to the cabbie dispatch app 0.1"
    options
  end

  def options
    @test = 0
    puts "What would you like to do? (select 1-3)"
    puts "1. Create new client" #call client_check
    puts "1. Schedule a new trip"
    puts "2. Update or View an existing trip"
    puts "3. Add new driver to database"
    puts "4. Add new vehicle to database"
    puts "5. Quit"

    case gets.strip
    when "1"
      schedule_new_trip
    when "2"
      seperator_and_text {puts "Enter the trip ID:"}
      @trip_id = gets.strip.to_i
      update_or_view_existing_trip
    when "3"
      driver_prompt
    when "4"
      vehicle_prompt
    when "5"
      exit
    else
      puts "Invalid Input: Please Enter 1-3"
      options
    end
  end

  def schedule_new_trip
    @test = 1
    client = client_check
    new_trip = get_trip_attributes_and_create
    new_trip.update(client: client)
    trip_creation_output(new_trip)
    seperator_and_text {puts "To add driver or vehicle now select 'Update or View an existing trip' from the main menu then choose to 'Update an existing trip'"
    puts "Press return to go back to the main menu:"}
    gets.strip
    options
  end

  def trip_creation_output(new_trip)
    puts "Trip number: #{new_trip.id}"
    seperator_and_text {puts "Trip Details"}
    case new_trip.num_of_pass
    when > 2
      x = "and #{new_trip.num_of_pass - 1} friends "
    when 2
      x = "and 1 friend "
    else
      x = ""
    end
    puts "Taking #{new_trip.client.first_name} #{x}from #{new_trip.pickup_loc} to #{new_trip.dropoff_loc}."
    puts "Your trip should take approximately #{new_trip.estimated_time_minutes} minutes. This should get you to your destination around #{new_trip.dropoff_time.hour}:#{new_trip.dropoff_time.min}"
  end

  def seperator_and_text
    puts "-------------------------------------------------"
    yield
    puts "-------------------------------------------------"
  end

  def client_check
    puts "Enter client full name:"
    name = gets.strip.split(" ")
    client = Client.find_by({first_name: name[0], last_name: name[1]})
    if client
      puts "This client already exists. Their client id is #{client.id}."
      options if @test == 0
      client
    else
      client_prompt
    end
  end

  def client_prompt
      seperator_and_text{puts "Client not found in database."
                         puts "Please input the following information:"
                         puts "(if information is unavailible simply hit return)"}
      client_new = get_client_attributes_and_create(name)
      puts "A new client has been added to your database"
      puts "New Client ID: #{client_new.id}"
      puts "Client name: #{name}"
      if @test == 0
        seperator_and_text {puts "Press return to go back to the main menu:"}
        gets.strip
        options
      end
      client_new
  end

  def get_client_attributes_and_create(name)
      attributes = {first_name: name[0], last_name: name[1],
                    company: "Client company" , phone: "Clients phone number", email: "Client's email address",
                    address: "Clients home address" }

      seperator_and_text {puts "Please input the following information:"
                          puts "(if information is unavailible simply hit return)"}

      attributes.drop(2).collect do |key, value|
        puts "#{value}:"
        attributes[key] = gets.strip
      end
      Client.create(attributes)
  end

  def get_trip_attributes_and_create
    attributes = {num_of_pass: "How many passengers", pickup_time: "Pick up date and time", pickup_loc: "Pick up address/location", dropoff_loc: "Drop off address/location"}

    seperator_and_text {puts "Please input the following information:"
                        puts "(if information is unavailible simply hit return)"}

    attributes.collect do |key, value|
      puts "#{value}:"
      if key == :pickup_time
        attributes[key] = time_array
      else
        attributes[key] = gets.strip
      end
    end
    Trip.create(attributes)
  end

  def time_array
    time_array = []
    what_array = ["year", "month", "day", "hour(24HR)", "minute"]
    what_array.each do |value|
      puts "Enter the #{value}: "
      time_array << gets.strip.to_i
    end
    Time.utc(*time_array)
  end

  def driver_prompt
    puts "Enter new driver's information:"
    new_driver = get_driver_attributes_and_create
    puts "A new driver has been created"
    puts "New Driver ID: #{new_driver.id}"
    puts "Driver name: #{new_driver.name}"
    seperator_and_text {puts "Press return to go back to the main menu:"}
    get.strip
    options
  end

  def get_driver_attributes_and_create
    attributes = {
      name: "Name of driver", age: "Age of driver",
      experience: "Years of experience driving",
      phone: "Driver phone number", email: "Driver's email address",
      address: "Driver's home address", lic_state: "License state",
      lic_number: "License number", lic_class: "License class"
    }
   attributes.collect do |key, value|
     puts "#{value}:"
     attributes[key] = gets.strip
   end
   Driver.create(attributes)
  end

  def vehicle_prompt
    puts "Enter new vehicle's information:"
    vehicle_new = get_vehicle_attributes_and_create
    puts "A new vehicle has been added to the garage"
    puts "New Vehicle ID: #{vehicle_new.id}"
    seperator_and_text {puts "Press return to go back to the main menu:"}
    gets.strip
    options
  end

  def get_vehicle_attributes_and_create
    attributes = {
      lic_plate: "License plate number", year: "Year of vehicle",
      make: "Make", model: "Model", color: "Color",
      seats: "How many seats", mileage: "Current mileage",
      type_of_veh: "Type of vehicle", veh_class: "License class required to drive"
    }
   attributes.collect do |key, value|
     puts "#{value}:"
     attributes[key] = gets.strip
   end
   Vehicle.create(attributes)
 end

 def update_or_view_existing_trip
    seperator_and_text {puts "What would you like to do? (select 1-3)"
                        puts "1. Update an existing trip"
                        puts "2. View an existing trip"
                        puts "3. Back to main menu"}
                        #add /n and remove puts
    case gets.strip
    when "1"
      update_trip
    when "2"
      view_trip
    when "3"
      options
    else
      puts "Invalid Input: Please Enter 1-3"
      update_or_view_existing_trip
    end
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
     puts "Invalid Input: Please Enter 1-5"
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
     options
   else
     puts "Invalid Input: Please Enter y or n"
     do_you_want_to_continue_updating_trip
   end
 end

 def view_trip
  trip = Trip.find(@trip_id)
  seperator_and_text {puts "Trip Details (Trip ID: #{@trip_id})"}
  puts "Driver Name: #{trip.driver.name}"
  puts "Vehicle Type: #{trip.vehicle.year} #{trip.vehicle.make} #{trip.vehicle.model}"
  puts "Client Name: #{trip.client.first_name} #{trip.client.last_name}"
  puts "Price: #{trip.price_string}"
  puts "Miles: #{trip.miles}"
  puts "Number of Passengers: #{trip.num_of_pass}"
  puts "Pick-Up Time: #{trip.pickup_time}"
  puts "Pick-Up Location: #{trip.pickup_loc}"
  puts "Drop-Off Time: #{trip.dropoff_time}"
  puts "Drop-ff Location: #{trip.dropoff_loc}"
  update_or_view_existing_trip
 end

end
















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
