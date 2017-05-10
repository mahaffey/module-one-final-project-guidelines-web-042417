class VehicleCLI

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

end
