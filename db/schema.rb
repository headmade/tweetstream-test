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

ActiveRecord::Schema.define(version: 20130909193400) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hashtags", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text",       null: false
  end

  create_table "hashtags_topics", id: false, force: true do |t|
    t.integer "topic_id",   null: false
    t.integer "hashtag_id", null: false
  end

  add_index "hashtags_topics", ["topic_id"], name: "index_hashtags_topics_on_topic_id", using: :btree

  create_table "topics", force: true do |t|
    t.string   "title"
    t.integer  "tweets_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "track_phrases", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text",       null: false
  end

  create_table "tweet_hashtags", force: true do |t|
    t.integer "tweet_id",   null: false
    t.integer "hashtag_id", null: false
  end

  add_index "tweet_hashtags", ["hashtag_id"], name: "index_tweet_hashtags_on_hashtag_id", using: :btree
  add_index "tweet_hashtags", ["tweet_id"], name: "index_tweet_hashtags_on_tweet_id", using: :btree

  create_table "tweets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tweet",      null: false
    t.text     "raw",        null: false
  end

end
