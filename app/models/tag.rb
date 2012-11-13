class Tag < ActiveRecord::Base
  belongs_to :phone
  attr_accessible :id, :phone, :key, :value 
end
