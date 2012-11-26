class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  make_flaggable :like

attr_accessible :id, :user, :review, :comment_text, :user_id, :review_id
end
