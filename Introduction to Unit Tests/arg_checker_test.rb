# Class that contains all unit tests for arg_checker class.

require 'minitest/autorun'
require_relative 'arg_checker'

class ArgCheckerTest < Minitest::Test
	# UNIT TESTS FOR METHOD check_args
	# Equivalence classes:
	# arr = minimum of FIXNUM to maximum of FIXNUM excluding 0 --> sets seed to value of arr[0].
	# arr != string that can be converted to a valid FIXNUM --> sets seed to 0.
	# arr.length != 1 --> raises exception and exits program.
	# This test checks that an invalid array (zero arguments) for ARGV raises an exception.
	# EDGE CASE
	def test_args_zero_arguments_provided_as_seed_value
		arg_checker = ArgsChecker::new
		arr = []
		exception = assert_raises(Exception) { arg_checker.check_args(arr)}
		assert_equal "Enter a seed and only a seed!", exception.message
	end

	# This test checks that an invalid array (more than one argument) for ARGV raises an exception.
	# EDGE CASE
	def test_args_more_than_one_argument_provided_as_seed_value
		arg_checker = ArgsChecker::new
		arr = [2233, 3, 4820]
		exception = assert_raises(Exception) { arg_checker.check_args(arr)}
		assert_equal "Enter a seed and only a seed!", exception.message
	end

	# This test checks that an invalid array (string) for ARGV causes the seed value to be set to 0.
	def test_args_invalid_arguments_provided_as_seed_value
		arg_checker = ArgsChecker::new
		arr = ["LaboonIsTheGoatOfBitcoin"]
		seed = arg_checker.return_seed_val(arr)
		assert_equal seed, 0
		refute_equal seed, arr[0]
	end
end
