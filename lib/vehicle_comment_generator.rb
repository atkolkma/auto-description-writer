require_relative "./aul_dabbler.rb"

def build_mentionable_features_array (any_aul_id)
	all_features_grabber = AulDabbler.new
	features = all_features_grabber.grab_possible_features(any_aul_id)
end




# unmentionable_features = Hash.new
# unmentionable_features["safety"] = unmentionable_safety_features = [""]
# unmentionable_features["convenience"] = unmentionable_convenience_features = [""]
# unmentionable_features["exterior"] = unmentionable_exterior_features = [""]
# unmentionable_features["seating"] = unmentionable_seating_features = [""]
# unmentionable_features["power"] = unmentionable_power_features = [""]
# unmentionable_features["drivetrain"] = unmentionable_drivetrain_features = [""]
# unmentionable_features["truck"] = unmentionable_truck_features = [""]
# unmentionable_features["customconversion"] = unmentionable_customconversion_features = [""]
# unmentionable_features["transmission"] = unmentionable_transmission_features = [""]




# def build_mentionable_features_arrays (features_list_page)

# 	mentionable_saftey(features_list_page)
# 	mentionable_convenience(features_list_page)
# 	mentionable_exterior(features_list_page)
# 	mentionable_seating(features_list_page)
# 	mentionable_power(features_list_page)
# 	mentionable_saftey(features_list_page)
# 	mentionable_saftey(features_list_page)
# 	mentionable_saftey(features_list_page)
# end

def generate_all_vehicle_comments (vehicles_data)
	comments_table = Array.new
	vehicles_data.each do |n|
		vehicle_comment = {"vin" => n["vin"], "stock_num" => n["stock_num"], "comment" => comment_generator(n)}
		comments_table.push(vehicle_comment)
	end
	comments_table
end

def comment_generator (vehicle)
	"This is a comment"
end