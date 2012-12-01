class CreatePhones < ActiveRecord::Migration
  def up
    create_table :phones do |t|
      t.integer :id
      t.string :name
      t.string :brand
      t.string :imgurl

      t.integer :num_reviews
      t.integer :overall_rating   # -1, at the first time

      t.timestamps
    end
  end
  def down
    drop_table :phones
  end
end
