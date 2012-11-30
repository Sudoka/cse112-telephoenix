class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :comment
      t.integer :value

      t.timestamps
    end
    add_index :likes,:comment_id
  end
end
