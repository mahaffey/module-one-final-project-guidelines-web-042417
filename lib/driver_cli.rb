class DriverCLI

  def driver_prompt
    puts "Enter new driver's information:"
    get_driver_attributes_and_creates
    puts "Driver submitted"
  end


  def get_driver_attributes_and_creates
    full_names = {name: "Name",
                  age: "Age",
                  experience: "Years of Experience",
                  phone: "Phone Number",
                  email: "Email Address",
                  address: "Home Address",
                  lic_state: "License State",
                  lic_number: "License Number",
                  lic_class: "License Class"}

   attributes = {}

   full_names.each do |key, value|
     puts "#{value}:"
     attributes[key] = gets.strip
   end

   Driver.create(attributes)
 end

end
