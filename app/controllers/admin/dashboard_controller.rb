class Admin::DashboardController < ApplicationController
	before_action :authenticate_admin!
  def index
  	@posts = Post.all
  end

  def drafts
  	@posts = Post.where(published: false)
  end
end
