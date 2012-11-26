class Flag < ActiveRecord::Base
  belongs_to :moderator
    belongs_to :user
      has_many :review  
      attr_accessible :id, :user, :phone, :review_text, :rating, :user_id, :phone_id 
end
