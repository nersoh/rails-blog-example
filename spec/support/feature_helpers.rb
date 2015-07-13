module FeatureHelpers
	def log_in(user)
		visit new_admin_session_path
		fill_in "admin_email", with: user.email
		fill_in "admin_password", with: user.password
		click_button "Log in"
	end
end

include FeatureHelpers