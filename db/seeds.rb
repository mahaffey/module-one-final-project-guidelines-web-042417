client_data = [
  [Faker::Name.unique.first_name, Faker::Name.unique.last_name, Faker::Company.name, Faker::Number.number(10), Faker::Internet.email, Faker::Address.street_address],
  [Faker::Name.unique.first_name, Faker::Name.unique.last_name, Faker::Company.name, Faker::Number.number(10), Faker::Internet.email, Faker::Address.street_address],
  [Faker::Name.unique.first_name, Faker::Name.unique.last_name, Faker::Company.name, Faker::Number.number(10), Faker::Internet.email, Faker::Address.street_address],
  [Faker::Name.unique.first_name, Faker::Name.unique.last_name, Faker::Company.name, Faker::Number.number(10), Faker::Internet.email, Faker::Address.street_address],
  [Faker::Name.unique.first_name, Faker::Name.unique.last_name, Faker::Company.name, Faker::Number.number(10), Faker::Internet.email, Faker::Address.street_address]
]

vehicle_data = [
  [Faker::Code.asin, Faker::Number.number(4), Faker::Vehicle.manufacture, Faker::Color.color_name],
  [Faker::Code.asin, Faker::Number.number(4), Faker::Vehicle.manufacture, Faker::Color.color_name],
  [Faker::Code.asin, Faker::Number.number(4), Faker::Vehicle.manufacture, Faker::Color.color_name],
  [Faker::Code.asin, Faker::Number.number(4), Faker::Vehicle.manufacture, Faker::Color.color_name],
  [Faker::Code.asin, Faker::Number.number(4), Faker::Vehicle.manufacture, Faker::Color.color_name]
]

driver_data = [
  [Faker::Name.name, Faker::Number.number(2), Faker::Number.number(1), Faker::Number.number(10)],
  [Faker::Name.name, Faker::Number.number(2), Faker::Number.number(1), Faker::Number.number(10)],
  [Faker::Name.name, Faker::Number.number(2), Faker::Number.number(1), Faker::Number.number(10)],
  [Faker::Name.name, Faker::Number.number(2), Faker::Number.number(1), Faker::Number.number(10)],
  [Faker::Name.name, Faker::Number.number(2), Faker::Number.number(1), Faker::Number.number(10)]
]

client_data.each do |first_name, last_name, company, phone, email, address|
  Client.create(first_name: first_name, last_name: last_name, company: company, phone: phone, email: email, address: address)
end

vehicle_data.each do |lic_plate, year, make, color|
  Vehicle.create(lic_plate: lic_plate, year: year, make: make, color: color)
end

driver_data.each do |name, age, experience, phone|
  Driver.create(name: name, age: age, experience: experience, phone: phone)
end
