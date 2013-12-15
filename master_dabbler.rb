require "./lib/aul_dabbler.rb"
require "./lib/carfax_dabbler.rb"
require "./lib/inventory_table_methods.rb"



#######Login to AUL and gabs basic info on all vehicles in inventory###############

aul_dabbler = AulDabbler.new

aul_dabbler.aul_login

inventory = aul_dabbler.vehicle_table

puts inventory.used.with_comments
puts inventory.length
puts inventory.used.length
puts inventory.used.with_comments.length

puts "done"





# carfax_dabbler = CarFaxDabbler.new
# carfax_dabbler.carfax_login

# carfax_dabbler.carfax_vin_search("1G1AT58H697144202")

# puts carfax_dabbler.agent.page.links

# puts "http://www.carfaxonline.com/api/report?vin=#{vin}&track=true"