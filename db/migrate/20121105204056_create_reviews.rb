class CreateReviews < ActiveRecord::Migration
  def up
    create_table :reviews do |t|
      t.integer :id
      t.references :user;
      t.integer :rating
      t.references :phone
      t.string :review_text
      t.timestamps
    end
  end
  def down
    drop_table :reviews
  end
end
