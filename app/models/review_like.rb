class ReviewLike < ActiveRecord::Base
	belongs_to :user
	belongs_to :review 
	attr_accessible :like
	#has_many :like
end
