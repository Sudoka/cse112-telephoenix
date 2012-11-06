class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.integer :id
      t.integer :username
      t.string :email
      t.string :password
      t.string :ip_address

      t.timestamps
    end
  end
  def down
    drop_table :users
  end
end
