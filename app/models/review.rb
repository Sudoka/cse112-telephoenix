class Review < ActiveRecord::Base
  belongs_to :phone
  belongs_to :user
  has_many :review_like
  has_many :comments
  make_flaggable :like
  attr_accessible :id, :user, :phone, :review_text, :rating, :user_id, :phone_id

end
