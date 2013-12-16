require "./lib/aul_dabbler.rb"
require "./lib/carfax_dabbler.rb"
require "./lib/data_parsing_methods.rb"



#######Login to AUL and gabs basic info on all vehicles in inventory###############

aul_dabbler = AulDabbler.new

aul_dabbler.aul_login

inventory = aul_dabbler.create_vehicle_table


######Grabs vehicle feature data from AUL on all used vehicles with no comments########

# puts aul_dabbler.grab_vehicle_features(inventory[7]["aul_id"])

used_inventory_data = inventory.used.no_comments

used_inventory_data.each do |n|
	n["features"] = aul_dabbler.grab_vehicle_features(n["aul_id"])["features"]
	n["engine"] = aul_dabbler.grab_vehicle_features(n["aul_id"])["engine"]
	n["trans"] = aul_dabbler.grab_vehicle_features(n["aul_id"])["trans"]
	n["miles"] = aul_dabbler.grab_vehicle_features(n["aul_id"])["miles"]
	n["color"] = aul_dabbler.grab_vehicle_features(n["aul_id"])["color"]
end

puts used_inventory_data[7]









# carfax_dabbler = CarFaxDabbler.new
# carfax_dabbler.carfax_login

# carfax_dabbler.carfax_vin_search("1G1AT58H697144202")

# puts carfax_dabbler.agent.page.links

# puts "http://www.carfaxonline.com/api/report?vin=#{vin}&track=true"