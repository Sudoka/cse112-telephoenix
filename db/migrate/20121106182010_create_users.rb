class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.integer :id
      t.string :username
      t.string :email
      t.string :hashed_password
      t.string :testing
      t.string :salt
      t.string :ip_address
      t.string :user_type

      t.timestamps
    end
  end
  def down
    drop_table :users
  end
end
