class UserType < ActiveRecord::Base
  belongs_to :user
  make_flagger
  attr_accessible :user_id, :user_type
end
