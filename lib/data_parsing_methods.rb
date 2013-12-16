class Array

	def used
		self.select { |entry| entry["inv_type"] == "U"}
	end

	def no_comments
		self.select { |entry| entry["comment"] == ""}
	end

end

class String

	def enter_csvs_into_hash(existing_hash)
	end

end


