class CLI
  #1 welcome
  def welcome
    puts "Welcome to the cabbie dispatch app 0.1"
    options
  end

  def options
    puts "What would you like to do? (select 1-3)"
    puts "1. Schedule a new trip"
    puts "2. Update or View an existing trip"
    puts "3. Quit"

    case gets.strip
    when "1"
      schedule_new_trip
    when "2"
      modify_or_view_existing_trip
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
    attributes
  end

  def driver_prompt
    puts "Enter new driver's information:"
    new_driver = get_driver_attributes_and_create
    puts "A new driver has been created"
    puts "Driver ID number: #{new_driver.id}"
    puts "Driver name: #{new_driver.name}"
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
    puts "New Vehicle ID: ##{vehicle_new.id}"
  end

  def get_vehicle_attributes_and_create
    attributes = {
      lic_plate: "License plate number", year: "Year of vehicle",
      make: "Make", model: "Model", color: "Color",
      seats: "How many seats", mileage: "Current mileage",
      type: "Type of vehicle", veh_class: "License class required to drive"
    }
   attributes.collect do |key, value|
     puts "#{value}:"
     attributes[key] = gets.strip
   end
   Vehicle.create(attributes)
 end

 def get_trip_id
    seperator_and_text {puts "Enter the trip ID"}
    gets.strip.to_i
  end

 def update_or_view_existing_trip
    seperator_and_text {puts "What would you like to do? (select 1-3)" puts "1. Update an existing trip" puts "2. View an existing trip" puts "3. Back to main menu"}
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

 # def updated_attributes
 #   attributes = {num_of_pass: "How many passengers", pickup_time: "Pick up time", pickup_loc: "Pick up address: (Street, Zip)", dropoff_loc: "Drop off address: (Street, Zip)"}
 #
 #   seperator_and_text {puts "Please input the following information:"
 #                       puts "(if information is unavailible simply hit return)"}
 #
 #   attributes.collect do |key, value|
 #     puts "#{value}:"
 #     attributes[key] = gets.strip
 #   end
 #   attributes
 # end

 def update_trip
   key = nil
   puts "What would you like to update? (select 1-5)"
  attributes = {num_of_pass: "How many passengers", pickup_time: "Pick up time", pickup_loc: "Pick up address: (Street, Zip)", dropoff_loc: "Drop off address: (Street, Zip)"}
  puts "1. Number of Passengers"
  puts "2. Pickup Time"
  puts "3. Pickup Location"
  puts "4. Dropoff Location"
  puts "5. Go Back"
   case gets.strip
   when "1"
     key = :num_of_pass
   when "2"
     key = :pickup_time
   when "3"
     key = :pickup_loc
   when "4"
     key = :dropoff_loc
   when "5"
     update_or_view_existing_trip
   else
     puts "Invalid Input: Please Enter 1-5"
     update_trip
   end
   Trip.all.where("ID = #{get_trip_id}").update("#{key} = #{get_value_input}")
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

 def get_value_input
   puts "Enter New Value:"
   gets.strip
 end

 def view_trip
   Trip.all[get_trip_id-1]
   update_or_view_existing_trip
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
