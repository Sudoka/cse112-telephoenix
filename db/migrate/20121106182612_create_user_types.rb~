class CreateUserTypes < ActiveRecord::Migration
  def up
    create_table :user_types do |t|
      t.references :user
      t.string :user_type

      t.timestamps
    end
  end
  def down
    drop_table :user_types
  end
end
