# Class that contains attributes for an individual driver.

class Driver
	attr_reader :driver_id, :num_classes, :num_dinos, :num_books, :curr_location, :last_location, :next_location, :driver_done
	attr_writer :num_classes, :num_dinos, :num_books, :curr_location, :last_location, :next_location, :driver_done

	def initialize(driver_id)
		if driver_id.to_i > 0
			@driver_id = driver_id
		else
			raise "Invalid driver ID provided!"
		end
		@num_classes = 1
		@num_dinos = 0
		@num_books = 0
		@driver_done = 0
		@curr_location = ""
		@next_location = ""
	end

	def get_start_location(seed)
		value = seed % 4
		if value < 0 || value > 3
			raise "Invalid modulus value returned!"
		end
		value
	end

	def check_driver_done(driver)
		if driver.curr_location == "Downtown" || driver.curr_location == "Monroeville"
			driver.driver_done = 1
		end
		driver.driver_done
	end

	def print_items(driver)
		if driver.num_dinos == 1
			dino_word = "toy"
		else
			dino_word = "toys"
		end
		if driver.num_books == 1
			book_word = "book"
		else
			book_word = "books"
		end
		if driver.num_classes == 1
			class_word = "class"
		else
			class_word = "classes"
		end
		books = "Driver #{driver.driver_id} obtained #{driver.num_books} #{book_word}!"
		dinos =  "Driver #{driver.driver_id} obtained #{driver.num_dinos} dinosaur #{dino_word}!"
		classes =  "Driver #{driver.driver_id} attended #{driver.num_classes} #{class_word}!"
		items = [books, dinos, classes]
		
		items
	end
end