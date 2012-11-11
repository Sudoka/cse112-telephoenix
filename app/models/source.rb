class Source < ActiveRecord::Base
  has_many :ratings
  attr_accessible :id, :name, :url, :category
end
