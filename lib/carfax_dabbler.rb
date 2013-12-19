require "rubygems"
require "mechanize"
require 'sanitize'


class CarFaxDabbler

	attr_reader :agent

	@@carfax_user = "C491181"
	@@carfax_pass = "37312"
	@@carfax_login_url = "http://www.carfaxonline.com"

	def initialize
	    @agent = Mechanize.new do |agent|
	      agent.user_agent_alias = 'Mac Safari'
	      agent.follow_meta_refresh = true
	      agent.redirect_ok = true
	    end
	end

	def carfax_login
	    @agent.get(@@carfax_login_url)
	    form = @agent.page.forms.first
	    form.j_username = @@carfax_user
	    form.j_password = @@carfax_pass
	    @agent.submit(form)
	end

	def carfax_vin_search (vin)
		@agent.get("http://www.carfaxonline.com/api/report?vin=#{vin}&track=true")
	end

	def grab_report_details (vin)
	@agent.get("http://www.carfaxonline.com/api/report?vin=#{vin}&track=true")

	output = Hash.new

	output["body_type"] = Sanitize.clean(@agent.page.search("#headerBodyType").to_s.gsub("\r", "\n")).strip
	output["engine"] = Sanitize.clean(@agent.page.search("#headerEngineInfo").to_s.gsub("\r", "\n")).strip
	output["drive_line"] = Sanitize.clean(@agent.page.search("#headerDriveline").to_s.gsub("\r", "\n")).strip
	output["full_title"] = Sanitize.clean(@agent.page.search("#headerMakeModelYear").to_s.gsub("\r", "\n")).strip

	output
end

end




