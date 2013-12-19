class Array

	def used
		self.select { |entry| entry["inv_type"] == "U"}
	end

	def no_comments
		self.select { |entry| entry["comment"] == ""}
	end

end


class String

	def capitalize_words

		words = self.split
		words.each {|n| n.capitalize!}
		words.join(" ")

	end

end




