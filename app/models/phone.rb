class Phone < ActiveRecord::Base
  has_many :tags
  has_many :ratings
  has_many :reviews
  attr_accessible :id, :name, :brand
end
