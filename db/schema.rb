# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20121119053426) do
=======
ActiveRecord::Schema.define(:version => 20121125193252) do

  create_table "admins", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end
>>>>>>> c1b0b56261c86ae4788ef0bd32ab2ab1cd405ec6

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "review_id"
    t.string   "comment_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

<<<<<<< HEAD
=======
  create_table "moderators", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

>>>>>>> c1b0b56261c86ae4788ef0bd32ab2ab1cd405ec6
  create_table "phones", :force => true do |t|
    t.string   "name"
    t.string   "brand"
    t.string   "imgurl"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratings", :force => true do |t|
    t.integer  "source_id"
    t.integer  "rating"
    t.integer  "number_reviews"
    t.integer  "phone_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "review_likes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "review_id"
    t.boolean  "like"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "rating"
    t.integer  "phone_id"
    t.string   "review_text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", :force => true do |t|
    t.integer  "phone_id"
    t.string   "key"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", :force => true do |t|
    t.integer  "user_id"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "testing"
    t.string   "salt"
    t.string   "ip_address"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
