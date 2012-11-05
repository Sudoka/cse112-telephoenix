class Phone < ActiveRecord::Base
  has_many :tags
  attr_accessible :id, :name, :brand
end
