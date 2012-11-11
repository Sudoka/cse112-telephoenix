class Phone < ActiveRecord::Base
  has_many :tags, :ratings, :reviews
  attr_accessible :id, :name, :brand
end
