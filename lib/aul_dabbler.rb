require "rubygems"
require "mechanize"
require 'sanitize'
require "~/development/automate\ vehicle\ descriptions/lib/data_parsing_methods.rb"

class AulDabbler

	attr_reader :agent

	@@aul_user = "ajaynes"
	@@aul_pass = "kayak1951"
	@@aul_login_url = "http://services.autouplinktech.com/login.cfm"

	def initialize
	    @agent = Mechanize.new do |agent|
	      agent.user_agent_alias = 'Mac Safari'
	      agent.follow_meta_refresh = true
	      agent.redirect_ok = true
	    end
	end

	def aul_login
	    @agent.get(@@aul_login_url)
	    form = @agent.page.forms.first
	    form.uid = @@aul_user
	    form.pid = @@aul_pass
	    @agent.submit(form)
	end

	def goto_comments_generator
		@agent.get("http://services.autouplinktech.com/admin/iim/navigation/home.cfm?CommentsGenerator=yes")
	end

	def goto_vehicle_details (vehicle_id)
		@agent.get("http://services.autouplinktech.com/admin/iim/CommentsWizard/ShortVehicleDetails.cfm?vehicleID=#{vehicle_id}")
	end

	def grab_details
	end

	def create_vehicle_table

		self.goto_comments_generator

		self.agent.page.frame_with(:name => 'bottom').click

		vehicle_data = self.agent.page.search("tr")

		vehicle_table = Array.new(0)

		vehicle_data.each do |n|
			vehicle_table.push(parse_row_to_array(n))
		end

		vehicle_table
	end


end


def parse_row_to_array (vehicle_row)
	vehicle_entries = vehicle_row.search("td")
	vehicle_info = Hash.new

	vehicle_info["aul_id"] = Sanitize.clean(vehicle_entries[0].to_s).strip
	vehicle_info["stock_num"] = Sanitize.clean(vehicle_entries[1].to_s).strip
	vehicle_info["year"] = Sanitize.clean(vehicle_entries[2].to_s).strip
	vehicle_info["make"] = Sanitize.clean(vehicle_entries[3].to_s).strip
	vehicle_info["model"] = Sanitize.clean(vehicle_entries[4].to_s).strip
	vehicle_info["package"] = Sanitize.clean(vehicle_entries[5].to_s).strip
	vehicle_info["vin"] = Sanitize.clean(vehicle_entries[7].to_s).strip
	vehicle_info["comment"] = Sanitize.clean(vehicle_entries[8].to_s).strip
	vehicle_info["inv_type"] = Sanitize.clean(vehicle_entries[9].to_s).strip

	vehicle_info
end


