require "rubygems"
require "mechanize"
require 'sanitize'
require "~/development/automate\ vehicle\ descriptions/lib/data_parsing_methods.rb"


class AulDabbler

	attr_reader :agent

	#set login credentials for Auto Uplink
	@@aul_user = "ajaynes"
	@@aul_pass = "kayak1951"
	@@aul_login_url = "http://services.autouplinktech.com/login.cfm"

	
	#create a Mechanize agent. Assigned to aul_dabbler in master_dabbler
	def initialize
	    @agent = Mechanize.new do |agent|
	      agent.user_agent_alias = 'Mac Safari'
	      agent.follow_meta_refresh = true
	      agent.redirect_ok = true
	    end
	end

	#login to Auto Uplink
	def aul_login
	    @agent.get(@@aul_login_url)
	    form = @agent.page.forms.first
	    form.uid = @@aul_user
	    form.pid = @@aul_pass
	    @agent.submit(form)
	end

	#Goes to the AUL comments generator page and creates an array of inventory data.
	#Each row is a hash with basic vehicle details for each entry.
	#This vehicle table is used in master_dabbler to reference specific vehicle ids
	def create_vehicle_table
		@agent.get("http://services.autouplinktech.com/admin/iim/navigation/home.cfm?CommentsGenerator=yes")

		@agent.page.frame_with(:name => 'bottom').click

		vehicle_data = self.agent.page.search("tr")

		vehicle_table = Array.new(0)

		vehicle_data.each do |n|
			vehicle_table.push(parse_row_to_array(n))
		end

		vehicle_table
	end

	#pulls vehicle features from AUL in the form of a single string. Features separated by commas
	def grab_vehicle_features (vehicle_id)
		@agent.get("http://services.autouplinktech.com/admin/iim/CommentsWizard/ShortVehicleDetails.cfm?vehicleID=#{vehicle_id}")
		table = @agent.page.search("td")
 		output = Hash.new

 		output["features"] = Sanitize.clean(table[7].to_s)
 		
		output["engine"] = Sanitize.clean(table[1].search("tr")[1].search("td")[0].to_s)
		output["trans"] = Sanitize.clean(table[1].search("tr")[2].search("td")[0].to_s)
		output["miles"] = Sanitize.clean(table[1].search("tr")[3].search("td")[0].to_s).to_i
		output["color"] = Sanitize.clean(table[1].search("tr")[4].search("td")[0].to_s)

		output

	end

	def grab_possible_features (any_aul_id)
		@agent.get("http://services.autouplinktech.com/admin/iim/InventoryManagement/UsedVeh.cfm?CurrentPage=1&SOrder=&Sort=&VehicleID=#{any_aul_id}&Edit=Yes&Inventory=Used&DealerID=9529&ViewAll=false&DisplayDeleted=0&DisplayActive=true")
	end


end

#takes a single vehicle row from the unparsed vehicle table (comments generator page of AUL) and converts it to a hash of vehicle details 
def parse_row_to_array (vehicle_row)
	vehicle_entries = vehicle_row.search("td")
	vehicle_info = Hash.new

	vehicle_info["aul_id"] = Sanitize.clean(vehicle_entries[0].to_s).strip
	vehicle_info["stock_num"] = Sanitize.clean(vehicle_entries[1].to_s).strip
	vehicle_info["year"] = Sanitize.clean(vehicle_entries[2].to_s).strip.to_i
	vehicle_info["make"] = Sanitize.clean(vehicle_entries[3].to_s).strip
	vehicle_info["model"] = Sanitize.clean(vehicle_entries[4].to_s).strip
	vehicle_info["package"] = Sanitize.clean(vehicle_entries[5].to_s).strip
	vehicle_info["vin"] = Sanitize.clean(vehicle_entries[7].to_s).strip
	vehicle_info["comment"] = Sanitize.clean(vehicle_entries[8].to_s).strip
	vehicle_info["inv_type"] = Sanitize.clean(vehicle_entries[9].to_s).strip

	vehicle_info
end

#builds arrays of valuable features

mentionable_features_grabber = AulDabbler.new



