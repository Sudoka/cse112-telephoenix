class Review < ActiveRecord::Base
  belongs_to :phone
  belongs_to :user
  has_many :review_like
  has_many :comments
  #make_flaggable :like
  attr_accessible :id, :user, :phone, :review_text, :rating, :user_id, :phone_id, :like
  def num_likes 
  	  likes = 0
  	  self.review_like.each do |rl|
  	  	  like = rl.like.nil? ?  1 : rl.like
  	  	  likes = likes + like
  	  end
  	  return likes
  end
end
