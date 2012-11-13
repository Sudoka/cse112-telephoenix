class Review < ActiveRecord::Base
  belongs_to :phone
  belongs_to :user
  attr_accessible :id, :user, :phone, :review_text, :rating, :user_id, :phone_id
end
