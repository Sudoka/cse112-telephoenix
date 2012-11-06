class UserType < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :user_type
end
