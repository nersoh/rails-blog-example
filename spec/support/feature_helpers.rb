module FeatureHelpers
	def log_in(user)
		visit new_admin_session_path
		fill_in "admin_email", with: user.email
		fill_in "admin_password", with: user.password
		click_button "Log in"
	end

	def create_post(title, content, published=false)
		post_title = title
    post_content = content
    fill_in "post_title", with: post_title
    fill_in "post_content", with: post_content
    if published
    	check("post_published")
    end
    click_button "Create post"
	end
end

include FeatureHelpers