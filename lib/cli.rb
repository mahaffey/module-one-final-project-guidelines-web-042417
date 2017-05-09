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

    case gets.chomp
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
    name = gets.chomp.split(" ")

    client = Client.find_by({first_name: name[0], last_name: name[1]})

    if client == nil
      Client.create(get_client_attributes)
    end
  end

  def get_client_attributes
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
