class Post < ActiveRecord::Base
	validates :title, presence: true
	validates_presence_of :content
end
