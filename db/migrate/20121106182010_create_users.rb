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
      ##facebook
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.datetime :oauth_expires_at
     
      t.timestamps
    end
  end
  def down
    drop_table :users
  end
end
