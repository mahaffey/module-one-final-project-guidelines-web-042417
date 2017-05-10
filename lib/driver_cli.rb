class DriverCLI

  def driver_prompt
    puts "Enter new driver's information:"
    new_driver = get_driver_attributes_and_create
    puts "A new driver has been created"
    puts "Driver ID number: #{new_driver.id}"
    puts "Driver name: #{new_driver.name}"
  end


  def get_driver_attributes_and_create
    attributes = {name: "Name of driver", age: "Age of driver",
                  experience: "Years of experience driving",
                  phone: "Driver phone number", email: "Driver's email address",
                  address: "Driver's home address", lic_state: "License state",
                  lic_number: "License number", lic_class: "License class"}

   attributes.collect do |key, value|
     puts "#{value}:"
     attributes[key] = gets.strip
   end

   Driver.create(attributes)
 end

end
