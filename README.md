# Cabbie CLI NYC Version 0.1

One Paragraph of project description goes here

## Getting Started

This is a CLI application intended to create, view, and alter various databases, which would be used for your common cabbie or black car depot. There are databases for Vehicles, Drivers and Clients. These 3 databases are relationally connected through a 4th Trips database.

Drivers have many Clients/Vehicles through Trips.
Clients have many and Drivers, Vehicles through Trips.
Vehicles have many Drivers/Clients through Trips.
Trips belong to Drivers/Clients/Vehicles.

The application uses the Google Maps API through the Google Directions Ruby Gem. We can input both starting and ending locations and are returned a trip duration (minutes) and a trip distance (miles). Using these two Trip attributes we created a Trip Pricing algorithm. Any company using this App can alter this algorithm to suit their needs. This method is located in the Trip Model in the lib folder.

Let's get started.
Fork/clone this repository in order to use this application. You must have Ruby Version 2.3 or higher in order to run the file at "./bin/run.rb". Please be sure to look at the included Gemfile and install all gems listed (Bundler is a great way to get these up and running).

### Prerequisites

* BASH command line
https://en.wikipedia.org/wiki/Bash_(Unix_shell)
* git version 1.3.0 (https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
* Ruby version 2.3.3
https://www.ruby-lang.org/en/documentation/installation/
* Bundler version 1.14.6
http://bundler.io/

### Installing

* If you don't know what these instructions mean look at the links above under Prerequisites.
* Be sure that you have Ruby 2.3.3 installed on your machine. Other versions may work but we cannot guarantee success at this time.
* Fork and clone this repo from Github
* Use Bundler to install all gems in the Gemfile
* run the "./bin/run.rb" file in BASH with with command "ruby bin/run.rb"
* congrats on your new database management system

## EXAMPLE USAGE

* Run the following command in your BASH terminal "ruby bin/run.rb"
* Look at your various options for entering in information
* We recommend that you choose either the create a new client, driver or vehicle before creating a trip.
* Based on your choice follow the instructions in the terminal and input the data requested to populate your database.
* Once you have at least one driver and vehicle inputed into the database you can finally create a trip.
* When you choose to create a trip you will be asked to input a client name. If the client already exists, their details will automatically be included with this new trip. If they do not exist, you will be asked to input their information before inputing the rest of the trip details.
* Follow the instructions in the terminal and input the requested data based on your choices.
* At the end of the data entry, you should see a message displaying the trip, driver, vehicle, and client details.
* To choose a specific driver or vehicle for a specific trip you may go into the modify existing trip menu and go from there.
* To view or modify any existing details you must know the ID of the entry you are trying to view or modify. You can find the option to see all IDs in the "Update or Modify Existing Entry" submenu.
* Congrats on your successful implementation of our App.
* If you have any questions you may ping the authors through github.com

## Built With
  * Atom version 1.16.0
  * Ruby version 2.3.3
  * Bundler version 1.14.6

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md)for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [git] with github (http://github.com/) for versioning.

## Authors

* **Ryan Mahaffey** - *Initial work* - [Mahaffey](https://github.com/mahaffey)

* **Andrew Oldham** - *Initial work* - [OtherWorldlyGuardian](https://github.com/otherworldlyguardian)

* **Alexandra Williams** - *Initial work* - [Alexandra-Williams](https://github.com/alexandra-williams)

See also the list of [contributors](https://github.com/mahaffey/module-one-final-project-guidelines-web-042417/contributors) for all who participated in this project.

## License

This project is licensed under the Learn CO and Authors License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Thank you to github user [JoshCrews] for the use of his open source Google Directions Gem (https://github.com/joshcrews/google-directions-ruby)
* Thank you to Google for the Google Maps API
