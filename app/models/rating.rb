class Rating < ActiveRecord::Base
  belongs_to :phone
  has_one :source
  attr_accessible :id, :source_id, :rating, :number_reviews, :phone_id
end
