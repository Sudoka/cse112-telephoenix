class Comment < ActiveRecord::Base
  belongs_to :review
  belongs_to :user
  #second report with an s
  make_flaggable :reports
  has_one :like
  attr_accessible :id, :user, :review, :comment_text, :user_id, :review_id, :like
  accepts_nested_attributes_for :like

end
