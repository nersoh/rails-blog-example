class Post < ActiveRecord::Base
	belongs_to :admin

	validates :title, presence: true
	validates_presence_of :content, :admin
end
