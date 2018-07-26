# Class that contains all unit tests for City_Sim_9006 class.
# These tests run simulations of the program with different seeds and test corresponding output.

require 'minitest/autorun'
require_relative 'driver'
require_relative 'city'

class CitySimTest < Minitest::Test
	# https://jacob.hoffman-andrews.com/README/ruby-function-stfu-temporarily-redirect-noisy-stdout-writes-to-devnull/
	def stfu
		begin
			orig_stderr = $stderr.clone
			orig_stdout = $stdout.clone
			$stderr.reopen File.new('/dev/null', 'w')
			$stdout.reopen File.new('/dev/null', 'w')
			retval = yield
		rescue Exception => e
			$stdout.reopen orig_stdout
			$stderr.reopen orig_stderr
			raise e
		ensure
			$stdout.reopen orig_stdout
			$stderr.reopen orig_stderr
		end
		retval
	end

	# UNIT TESTS FOR METHOD print_items
	# Equivalence classes:
	# None because this method only prints out precalculated values.
	# This test checks that a seed of 867530 results in Driver 1 collecting 3 dinosaur toys.
	def test_print_items_dinos
		mock_argv = [867530]
		ARGV.replace(mock_argv)
		require_relative 'city_sim_9006'
		prng = Random.new((ARGV[0]))
		oakland = City::new
		game = CitySim::new
		all_drivers = [d1 = Driver.new(1)]
		num_starting_locs = oakland.all_locations.length
		num_options = 2
		all_items = stfu do game.run_sim(all_drivers, oakland, prng, num_starting_locs, num_options) end
		assert_equal all_items[0].num_dinos, 3
	end

	# This test checks that a seed of 666 results in Driver 3 attending 16 classes.
	def test_print_items_classes
		mock_argv = [666]
		ARGV.replace(mock_argv)
		require_relative 'city_sim_9006'
		prng = Random.new((ARGV[0]))
		oakland = City::new
		game = CitySim::new
		all_drivers = [d1 = Driver.new(1), d2 = Driver.new(2), d3 = Driver.new(3)]
		num_starting_locs = oakland.all_locations.length
		num_options = 2
		all_items = stfu do game.run_sim(all_drivers, oakland, prng, num_starting_locs, num_options) end
		assert_equal all_items[2].num_classes, 16
	end

	# This test checks that a seed of 87 results in Driver 1 obtaining 3 books.
	def test_print_items_books
		mock_argv = [87]
		ARGV.replace(mock_argv)
		require_relative 'city_sim_9006'
		prng = Random.new((ARGV[0]))
		oakland = City::new
		game = CitySim::new
		all_drivers = [d1 = Driver.new(1)]
		num_starting_locs = oakland.all_locations.length
		num_options = 2
		all_items = stfu do game.run_sim(all_drivers, oakland, prng, num_starting_locs, num_options) end
		assert_equal all_items[0].num_books, 3
	end

	# This test checks that a seed of 16526 results in Driver 1 attending 2 classes.
	# EDGE CASE because Driver starts at Cathedral, so classes should be automatically start with 2 instead of 1.
	def test_print_items_classes_when_driver_starts_at_cathedral
		mock_argv = [16526]
		ARGV.replace(mock_argv)
		require_relative 'city_sim_9006'
		prng = Random.new((ARGV[0]))
		oakland = City::new
		game = CitySim::new
		all_drivers = [d1 = Driver.new(1)]
		num_starting_locs = oakland.all_locations.length
		num_options = 2
		all_items = stfu do game.run_sim(all_drivers, oakland, prng, num_starting_locs, num_options) end
		assert_equal all_items[0].num_classes, 2
	end
end