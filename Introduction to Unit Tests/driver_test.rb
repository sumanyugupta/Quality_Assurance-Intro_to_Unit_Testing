# Class that contains all unit tests for Driver class.

require 'minitest/autorun'
require_relative 'driver'

class DriverTest < Minitest::Test
	# UNIT TESTS FOR METHOD initialize in Driver class
	# Equivalence classes:
	# None because this method is a constructor for the Driver class.
	# This test checks that a new Driver's initial number of items correspond to the ones listed in the requirements.
	def test_check_inital_driver_items
		id = 1
		driver = Driver.new(id)
		assert_equal driver.num_dinos, 0
		refute_equal driver.num_classes, 10
		assert_equal driver.num_books, 0
	end

	# This test checks that a valid id of a Driver passed in matches the one it is initialized with.
	def test_check_initial_driver_id
		driver2 = Driver.new(2)
		driver5 = Driver.new(5)

		assert_equal driver2.driver_id, 2
		assert_equal driver5.driver_id, 5
	end

	# This test checks that an invalid Driver id raises an exception.
	def test_check_invalid_driver_id
		exception = assert_raises(Exception) { driver = Driver.new(-1)}
		assert_equal "Invalid driver ID provided!", exception.message
	end

	# UNIT TESTS FOR METHOD print_items
	# Equivalence classes:
	# None because this method only prints out precalculated values.
	# This test checks that Driver 3 collecting one book is printed as the singular "book" instead of "books"
	def test_print_items_books_word_is_singular_and_exclamation_point
		driver = Driver.new(1)
		driver.num_books = 1
		singular_sentence = driver.print_items(driver)[0]
		assert_includes singular_sentence, "book!"
	end

	# This test checks that Driver 3 attending multiple classes is printed as the plural "classes" instead of "class"
	def test_print_items_classes_word_is_plural_and_exclamation_point
		driver = Driver.new(1)
		driver.num_classes = 3
		plural_sentence = driver.print_items(driver)[2]
		assert_includes plural_sentence, "classes!"
	end

	# This test checks that the Driver's iteration is ended by going to Downtown or Monroeville.
	def test_driver_goes_to_other_place
		driver = Driver.new(1)
		driver.curr_location = "Monroeville"
		mock_driver = Minitest::Mock::new
		def mock_driver.check_driver_done; 1; end
		driver_status = driver.check_driver_done(driver)
		assert_equal driver_status, mock_driver.check_driver_done
	end

	# This test checks that the number of drivers initialized in the array of drivers matches the number simulated
	def test_check_driver_array_size
		all_drivers = [d1 = Driver.new(1), d2 = Driver.new(2)]
		assert_equal all_drivers.length, 2
	end
end