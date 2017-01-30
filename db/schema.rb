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

ActiveRecord::Schema.define(version: 20170130235729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "command_groups", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_command_groups_on_name", using: :btree
  end

  create_table "commands", force: :cascade do |t|
    t.integer  "command_group_id"
    t.integer  "message_type",     limit: 2, null: false
    t.text     "content"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["command_group_id"], name: "index_commands_on_command_group_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "event_type", limit: 2, null: false
    t.integer  "talk_id"
    t.datetime "timestamp"
    t.text     "content"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["event_type", "talk_id", "timestamp"], name: "index_events_on_event_type_and_talk_id_and_timestamp", using: :btree
    t.index ["talk_id"], name: "index_events_on_talk_id", using: :btree
    t.index ["timestamp"], name: "index_events_on_timestamp", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "message_type", limit: 2, null: false
    t.integer  "talk_id"
    t.integer  "event_id"
    t.text     "content"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["event_id"], name: "index_messages_on_event_id", using: :btree
    t.index ["talk_id", "message_type", "created_at"], name: "index_messages_on_talk_id_and_message_type_and_created_at", using: :btree
    t.index ["talk_id"], name: "index_messages_on_talk_id", using: :btree
  end

  create_table "talks", force: :cascade do |t|
    t.integer  "talk_type",   limit: 2, default: 0, null: false
    t.string   "receiver_id",                       null: false
    t.integer  "status",      limit: 2,             null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["receiver_id"], name: "index_talks_on_receiver_id", unique: true, using: :btree
    t.index ["status"], name: "index_talks_on_status", using: :btree
    t.index ["talk_type", "receiver_id"], name: "index_talks_on_talk_type_and_receiver_id", unique: true, using: :btree
  end

end
