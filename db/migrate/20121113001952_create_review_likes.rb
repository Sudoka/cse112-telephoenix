class CreateReviewLikes < ActiveRecord::Migration
  def up
    create_table :review_likes do |t|
    	t.references :user
    	t.references :review
    	t.integer :like
    	t.timestamps
    end
  end

  def down
  	drop_table :review_likes
  end
end
