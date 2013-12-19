class Array

	def used
		self.select { |entry| entry["inv_type"] == "U"}
	end

	def no_comments
		self.select { |entry| entry["comment"] == ""}
	end

end






