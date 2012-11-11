class Rating < ActiveRecord::Base
  has_one :phone
  has_one :source
  attr_accessible :id, :source_id, :rating, :number_reviews, :phone_id
end
