class Flag < ActiveRecord::Base
    belongs_to :user
    belongs_to :review
    attr_accessible :id, :user, :phone, :review_text, :rating, :user_id, :phone_id 
end
