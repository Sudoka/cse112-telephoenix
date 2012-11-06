class User < ActiveRecord::Base
  has_many :reviews
  attr_accessible :id, :username, :email, :password, :ip_address
end
