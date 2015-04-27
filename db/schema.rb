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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150420184032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cals", force: true do |t|
    t.integer  "user_id"
    t.integer  "calburnt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "userid"
    t.string   "integer"
    t.boolean  "fitbit"
    t.boolean  "aria"
    t.boolean  "fitbitActivation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",            default: false
    t.integer  "invitation_id"
    t.string   "oauth_token"
    t.string   "oauth_secret"
    t.string   "fitbit_id"
    t.string   "verifier",         default: "12"
    t.string   "request_token"
    t.string   "request_secret"
    t.string   "token"
  end

  add_index "clients", ["email"], name: "index_clients_on_email", unique: true, using: :btree
  add_index "clients", ["remember_token"], name: "index_clients_on_remember_token", using: :btree

  create_table "favorite_videos", force: true do |t|
    t.integer  "video_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitation2s", force: true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", force: true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "logs", force: true do |t|
    t.string   "sex"
    t.integer  "age"
    t.integer  "height"
    t.integer  "weight"
    t.integer  "goalweight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "height2"
  end

  create_table "messages", force: true do |t|
    t.string   "sender_id",                           null: false
    t.string   "recepient_id"
    t.boolean  "sender_deleted",    default: false
    t.boolean  "recepient_deleted", default: false
    t.string   "subject",                             null: false
    t.text     "body"
    t.datetime "read_at"
    t.string   "container",         default: "draft"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "weeks"
    t.integer  "time"
    t.boolean  "fat"
    t.boolean  "hiit"
    t.boolean  "core",       default: true
    t.boolean  "pilates"
    t.boolean  "yoga"
    t.boolean  "stretching", default: true
    t.boolean  "strength"
    t.boolean  "kettlebell"
    t.boolean  "barre"
    t.boolean  "dance"
    t.boolean  "boxing"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "goal"
  end

  create_table "searches", force: true do |t|
    t.integer  "duration"
    t.string   "fitnesstype"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trainer"
    t.string   "bodytype"
    t.integer  "difficulty"
    t.integer  "calories"
    t.integer  "user_id"
  end

  create_table "trainers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.integer  "invitation_id"
    t.string   "token"
  end

  add_index "trainers", ["email"], name: "index_trainers_on_email", unique: true, using: :btree
  add_index "trainers", ["remember_token"], name: "index_trainers_on_remember_token", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",                  default: true
    t.integer  "invitation_id"
    t.integer  "invitation_limit"
    t.string   "token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "calories"
    t.string   "timezone"
    t.boolean  "trainer",                default: false
    t.string   "trainer_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "videos", force: true do |t|
    t.string   "name"
    t.string   "tubeid"
    t.integer  "duration"
    t.string   "level"
    t.string   "equipment"
    t.string   "fitnesstype"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "difficulty"
    t.string   "trainer"
    t.string   "bodytype"
    t.integer  "calories"
  end

  create_table "weights", force: true do |t|
    t.integer  "weight"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "goalweight"
  end

  create_table "workouts", force: true do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.integer  "video_id"
    t.integer  "day"
    t.boolean  "complete"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
