module RequestHelpers
	def login_as_admin
		@admin = FactoryGirl.create(:admin)
	  post admin_session_path, "admin[email]" => @admin.email, "admin[password]" => @admin.password
	end
end

include RequestHelpers