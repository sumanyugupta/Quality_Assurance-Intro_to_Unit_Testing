# Class that contains the mappings for the city, including streets to and from the 6 locations on the map.

class City
	attr_reader :all_locations, :hospital_locs, :cathedral_locs, :hillman_locs, :museum_locs, :downtown, :monro
	attr_accessor :all_locations, :hospital_locs, :cathedral_locs, :hillman_locs, :museum_locs, :downtown, :monro

	def initialize
		@all_locations = ["Hospital", "Cathedral", "Hillman", "Museum"]
		@hospital_locs = ["Hospital", "Foo St.", "Fourth Ave."]
		@cathedral_locs = ["Cathedral", "Fourth Ave.", "Bar St."]
		@hillman_locs = ["Hillman", "Foo St.", "Fifth Ave."]
		@museum_locs = ["Museum", "Fifth Ave.", "Bar St."]
		@downtown = ["Downtown", "Fifth Ave."]
		@monro = ["Monroeville", "Fourth Ave."]
	end

	def generate_hospital_locs(street, rand_number)
		start = street.hospital_locs
		if rand_number == 1
			street_name = start & street.hillman_locs
			next_location = "Hillman"
		elsif rand_number == 0
			street_name = start & street.cathedral_locs
			next_location = "Cathedral"
		else
			raise "The generated random number is invalid!"
		end
		[next_location, street_name]
	end

	def generate_cathedral_locs(street, rand_number)
		start = street.cathedral_locs
		if rand_number == 1
			street_name = start & street.museum_locs
			next_location = "Museum"
		elsif rand_number == 0
			street_name = start & street.monro
			next_location = "Monroeville"
		else
			raise "The generated random number is invalid!"
		end
		[next_location, street_name]
	end

	def generate_museum_locs(street, rand_number)
		start = street.museum_locs
		if rand_number == 1
			street_name = start & street.hillman_locs
			next_location = "Hillman"
		elsif rand_number == 0
			street_name = start & street.cathedral_locs
			next_location = "Cathedral"
		else
			raise "The generated random number is invalid!"
		end
		[next_location, street_name]
	end

	def generate_hillman_locs(street, rand_number)
		start = street.hillman_locs
		if rand_number == 1
			street_name = start & street.hospital_locs
			next_location = "Hospital"
		elsif rand_number == 0
			street_name = start & street.downtown
			next_location = "Downtown"
		else
			raise "The generated random number is invalid!"
		end
		[next_location, street_name]
	end
end