require "./lib/aul_dabbler.rb"
require "./lib/carfax_dabbler.rb"
require "./lib/data_parsing_methods.rb"



#######Login to AUL and gabs basic info on all vehicles in inventory###############

aul_dabbler = AulDabbler.new

aul_dabbler.aul_login

inventory = aul_dabbler.create_vehicle_table


######Grabs detailed feature data from AUL on all used vehicles with no description########

puts aul_dabbler.grab_vehicle_details(inventory.used[50]["aul_id"])










# carfax_dabbler = CarFaxDabbler.new
# carfax_dabbler.carfax_login

# carfax_dabbler.carfax_vin_search("1G1AT58H697144202")

# puts carfax_dabbler.agent.page.links

# puts "http://www.carfaxonline.com/api/report?vin=#{vin}&track=true"