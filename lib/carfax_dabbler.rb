require "rubygems"
require "mechanize"


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

end
