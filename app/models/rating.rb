class Rating < ActiveRecord::Base
  belongs_to :phone
  belongs_to :source
  attr_accessible :id, :source_id, :rating, :number_reviews, :phone_id
end
