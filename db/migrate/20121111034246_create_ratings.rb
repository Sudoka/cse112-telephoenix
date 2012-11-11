class CreateRatings < ActiveRecord::Migration
  def up 
    create_table :ratings do |t|
      t.integer :id
      t.references :source
      t.integer :rating
      t.integer :number_reviews
      t.references :phone
      t.timestamps
    end
  end
  def down
    drop_table :ratings
  end
end
