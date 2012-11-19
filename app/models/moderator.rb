class Moderator< ActiveRecord::Base
  belongs_to :user_type
  attr_accessible :user_id, :user_type
end
