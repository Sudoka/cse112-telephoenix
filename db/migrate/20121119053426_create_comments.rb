class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.integer :id
      t.references :user;
      t.references :review
      t.string :comment_text
      t.timestamps
    end
  end
  def down
    drop_table :comments
  end
end
