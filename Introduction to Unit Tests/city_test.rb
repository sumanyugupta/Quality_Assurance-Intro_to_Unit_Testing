# Class that contains all unit tests for City class.

require 'minitest/autorun'
require_relative 'city'

class CityTest < Minitest::Test
	# UNIT TESTS FOR METHOD generate_hillman_locs
	# Equivalence classes:
	# rand_val = 0 --> Driver goes to Downtown from Hillman
	# rand_val = 1 --> Driver goes to Hospital from Hillman
	# This test checks that a driver can only move to Hospital from Hillman via Foo St. if rand_val is 1.
	def test_possible_location_from_hillman_if_rand_is_one
		oakland = City::new
		rand_val = 1
		hospital = oakland.generate_hillman_locs(oakland, rand_val)

		assert_equal hospital[0], "Hospital"
		assert_equal hospital[1][0], "Foo St."
	end

	# This test checks the street that a Driver takes to leave a location and go to an Other Place.
	def test_street_used_to_go_to_downtown
		oakland = City::new
		fifth = Minitest::Mock::new
		def fifth.street; "Fifth Ave."; end
		assert_includes oakland.generate_hillman_locs(oakland, 0)[1][0], fifth.street
	end

	# This test checks that a driver can only move to Downtown from Hillman via Fifth Ave. if rand_val is 1.
	# EDGE CASE
	def test_possible_location_from_hillman_if_rand_is_zero
		oakland = City::new
		rand_val = 0
		downtown = oakland.generate_hillman_locs(oakland, rand_val)

		assert_equal downtown[0], "Downtown"
		assert_equal downtown[1][0], "Fifth Ave."
	end

	# UNIT TESTS FOR METHOD generate_museum_locs
	# Equivalence classes:
	# rand_val = 0 --> Driver goes to Hillman from Museum
	# rand_val = 1 --> Driver goes to Cathedral from Museum
	# This test checks that a driver can only move to Hillman from Musuem via Fifth Ave. if rand_val is 1.
	def test_possible_location_from_museum_if_rand_is_one
		oakland = City::new
		rand_val = 1
		hillman = oakland.generate_museum_locs(oakland, rand_val)

		assert_equal hillman[0], "Hillman"
		assert_equal hillman[1][0], "Fifth Ave."
	end

	# This test checks that a driver can only move to Cathedral from Musuem via Bar St. if rand_val is 0.
	def test_possible_location_from_museum_if_rand_is_zero
		oakland = City::new
		rand_val = 0
		cathedral = oakland.generate_museum_locs(oakland, rand_val)

		assert_equal cathedral[0], "Cathedral"
		assert_equal cathedral[1][0], "Bar St."
	end

	# UNIT TESTS FOR METHOD generate_cathderal_locs
	# Equivalence classes:
	# rand_val = 0 --> Driver goes to Monroeville from Cathedral
	# rand_val = 1 --> Driver goes to Museum from Cathedral
	# This test checks that a driver can only move to Museum from Cathderal via Bar St. if rand_val is 1.
	def test_possible_location_from_cathedral_if_rand_is_one
		oakland = City::new
		rand_val = 1
		museum = oakland.generate_cathedral_locs(oakland, rand_val)

		assert_equal museum[0], "Museum"
		assert_equal museum[1][0], "Bar St."
	end

	# This test checks the street that a Driver takes to leave a location and go to an Other Place.
	def test_street_used_to_go_to_monroeville
		oakland = City::new
		fourth = Minitest::Mock::new
		def fourth.street; "Fourth Ave."; end
		assert_includes oakland.generate_cathedral_locs(oakland, 0)[1][0], fourth.street
	end

	# This test checks that a driver can only move to Hospital from Hillman via Fourth Ave. if rand_val is 0.
	# EDGE CASE
	def test_monroeville_from_cathedral_if_rand_is_zero
		oakland = City::new
		rand_val = 0
		monro = oakland.generate_cathedral_locs(oakland, rand_val)

		assert_equal monro[0], "Monroeville"
		assert_equal monro[1][0], "Fourth Ave."
	end

	# UNIT TESTS FOR METHOD generate_hospital_locs
	# Equivalence classes:
	# rand_val = 0 --> Driver goes to Cathderal from Hospital
	# rand_val = 1 --> Driver goes to Hillman from Hospital
	# This test checks that a driver can only move to Hillman from Hospital via Foo St. if rand_val is 1.
	def test_possible_location_from_hospital_if_rand_is_one
		oakland = City::new
		rand_val = 1
		hillman = oakland.generate_hospital_locs(oakland, rand_val)

		assert_equal hillman[0], "Hillman"
		assert_equal hillman[1][0], "Foo St."
	end

	# This test checks that a driver can only move to Cathedral from Hospital via Fourth Ave. if rand_val is 0.
	def test_possible_location_from_hospital_if_rand_is_zero
		oakland = City::new
		rand_val = 0
		cathedral = oakland.generate_hospital_locs(oakland, rand_val)

		assert_equal cathedral[0], "Cathedral"
		assert_equal cathedral[1][0], "Fourth Ave."
	end

	# UNIT TESTS FOR METHOD get_start_location
	# Equivalence classes:
	# rand_val = 0 --> Driver starts at Hospital
	# rand_val = 1 --> Driver starts at Cathedral
	# rand_val = 2 --> Driver starts at Hillman
	# rand_val = 3 --> Driver starts at Museum
	# This test checks for the Driver starting at Hospital when a random number of 0 is generated.
	def test_hospital_start_location
		rand_val = Minitest::Mock::new
		oakland = City::new
		def rand_val.get_start_location; 0; end
		start_loc = oakland.all_locations[rand_val.get_start_location]
		assert_equal start_loc, "Hospital"
	end

	# This test checks for the Driver starting at Cathedral when a random number of 1 is generated.
	def test_museum_start_location
		rand_val = Minitest::Mock::new
		oakland = City::new
		def rand_val.get_start_location; 1; end
		start_loc = oakland.all_locations[rand_val.get_start_location]
		assert_equal start_loc, "Cathedral"
	end

	# This test checks for the Driver starting at Hillman when a random number of 2 is generated.
	def test_cathedral_start_location
		rand_val = Minitest::Mock::new
		oakland = City::new
		def rand_val.get_start_location; 2; end
		start_loc = oakland.all_locations[rand_val.get_start_location]
		assert_equal start_loc, "Hillman"
	end

	# This test checks for the Driver starting at Museum when a random number of 3 is generated.
	def test_hillman_start_location
		rand_val = Minitest::Mock::new
		oakland = City::new
		def rand_val.get_start_location; 3; end
		start_loc = oakland.all_locations[rand_val.get_start_location]
		assert_equal start_loc, "Museum"
	end

	# This test checks that a driver never starts in Downtown or Monroeville.
	def test_other_start_location_false
		mock_driver = Minitest::Mock::new
		def mock_driver.get_start_location; 3; end
		oakland = City::new
		start_loc = oakland.all_locations[mock_driver.get_start_location]
		refute_includes start_loc, oakland.downtown[0]
		refute_includes start_loc, oakland.monro[0]
	end

	# This test checks that the city contains four locations, no matter the order in which they appear in an array.
	def test_all_locations
		oakland = City::new
		four_locations = ["Museum", "Cathedral", "Hospital", "Hillman"]
		assert_includes four_locations, oakland.all_locations[0], oakland.all_locations[1]
		assert_includes four_locations, oakland.all_locations[2], oakland.all_locations[3]
	end
end
