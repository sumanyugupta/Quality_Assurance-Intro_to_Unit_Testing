# Main class that executes the CitySim9006 driver simulations.

require_relative 'arg_checker'
require_relative 'city'
require_relative 'driver'
		
class CitySim
	attr_reader :street 
	def run_sim(all_drivers, oakland, prng, num_starting_locs, num_options)
		for driver in all_drivers do
			driver.curr_location = oakland.all_locations[driver.get_start_location(prng.rand(num_starting_locs))]
			driver.driver_done = 0
			while (driver.next_location != "Downtown" && driver.next_location != "Monroeville" && driver.driver_done != 1)
				case driver.curr_location
				when "Hospital"
					travel_information = oakland.generate_hospital_locs(oakland, prng.rand(num_options))
					driver.next_location = travel_information[0]
					@street = travel_information[1][0]
				when "Hillman"
					driver.num_books += 1
					travel_information = oakland.generate_hillman_locs(oakland, prng.rand(num_options))
					driver.next_location = travel_information[0]
					@street = travel_information[1][0]
				when "Museum"
					driver.num_dinos += 1
					travel_information = oakland.generate_museum_locs(oakland, prng.rand(num_options))
					driver.next_location = travel_information[0]
					@street = travel_information[1][0]
				when "Cathedral"
					driver.num_classes = driver.num_classes * 2
					travel_information = oakland.generate_cathedral_locs(oakland, prng.rand(num_options))
					driver.next_location = travel_information[0]
					@street = travel_information[1][0]
				end
				puts "Driver #{driver.driver_id} heading from #{driver.curr_location} to #{driver.next_location} via #{@street}"

				driver.curr_location = driver.next_location

				if driver.check_driver_done(driver) == 1
					puts driver.print_items(driver)
				end
			end
		end
	end

	arg_checker = ArgsChecker::new
	if !arg_checker.check_args(ARGV)
		prng = Random.new(arg_checker.return_seed_val(ARGV))
	end
	oakland = City::new
	all_drivers = [d1 = Driver.new(1), d2 = Driver.new(2), d3 = Driver.new(3), d4 = Driver.new(4), d5 = Driver.new(5)]

	num_starting_locs = oakland.all_locations.length
	num_options = 2

	new.run_sim(all_drivers, oakland, prng, num_starting_locs, num_options)
end
