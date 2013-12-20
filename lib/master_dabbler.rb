require_relative "./aul_dabbler.rb"
require_relative "./carfax_dabbler.rb"
require_relative "./data_parsing_methods.rb"



#######Login to AUL and gabs basic info on all vehicles in inventory###############

aul_dabbler = AulDabbler.new

aul_dabbler.aul_login

inventory = aul_dabbler.create_vehicle_table


######Grabs vehicle feature data from AUL on all used vehicles with no comments########

used_inventory_data = inventory.used.no_comments

# used_inventory_data.each do |n|
# 	vehicle_data = aul_dabbler.grab_vehicle_features(n["aul_id"])
# 	n["features"] = vehicle_data["features"]
# 	n["engine"] = vehicle_data["engine"]
# 	n["trans"] = vehicle_data["trans"]
# 	n["miles"] = vehicle_data["miles"]
# 	n["color"] = vehicle_data["color"]
# end

#####Login to Carfax and add vehicle data to used_inventory_data

carfax_dabbler = CarFaxDabbler.new
carfax_dabbler.carfax_login

used_inventory_data.each do |n|
	vehicle_data = carfax_dabbler.grab_report_details(n["vin"])
	n["body_type"] = vehicle_data["body_type"]
	n["engine"] = vehicle_data["engine"]
	n["drive_train"] = vehicle_data["drive_train"]
	n["full_title"] = vehicle_data["full_title"]
	n["damage"] = vehicle_data["damage"]
	n["certified"] = vehicle_data["certified"]
	n["maintenance"] = vehicle_data["maintenance"]
	n["number_owners"] = vehicle_data["number_owners"]
end

puts used_inventory_data

