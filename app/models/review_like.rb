class ReviewLike < ActiveRecord::Base
	belongs_to :user
	belongs_to :review 
	attr_accessible :like
	#make_flag
end
