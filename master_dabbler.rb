require "./lib/aul_dabbler.rb"
require "./lib/carfax_dabbler.rb"
require "./lib/data_parsing_methods.rb"



#######Login to AUL and gabs basic info on all vehicles in inventory###############

aul_dabbler = AulDabbler.new

aul_dabbler.aul_login

inventory = aul_dabbler.create_vehicle_table

puts inventory.used.length

puts "done"

######Grabs detailed feature data from AUL on all used vehicles with no description########











# carfax_dabbler = CarFaxDabbler.new
# carfax_dabbler.carfax_login

# carfax_dabbler.carfax_vin_search("1G1AT58H697144202")

# puts carfax_dabbler.agent.page.links

# puts "http://www.carfaxonline.com/api/report?vin=#{vin}&track=true"