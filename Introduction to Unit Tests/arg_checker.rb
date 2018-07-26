# Class that checks and returns a valid seed value to be used by the pseudorandom generator.

class ArgsChecker
	def check_args(arr)
		if arr.count != 1
			raise "Enter a seed and only a seed!"
		end
	end

	def return_seed_val(arr)
		begin
			seed_val = Integer(arr[0])
		rescue ArgumentError
			seed_val = 0
		end
		seed_val
	end
end