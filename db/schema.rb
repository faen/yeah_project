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

ActiveRecord::Schema.define(:version => 20110309130152) do

  create_table "acceptance_tests", :force => true do |t|
    t.integer  "user_story_id"
    t.boolean  "fulfilled"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", :force => true do |t|
    t.integer  "country_id"
    t.integer  "region_id"
    t.string   "city"
    t.string   "zip"
    t.string   "street"
    t.string   "street_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "backlogs", :force => true do |t|
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "phone"
    t.string   "mobile"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.string   "fips104",              :limit => 2,  :null => false
    t.string   "iso2",                 :limit => 2,  :null => false
    t.string   "iso3",                 :limit => 3,  :null => false
    t.string   "ison",                 :limit => 4,  :null => false
    t.string   "internet",             :limit => 2,  :null => false
    t.string   "capital",              :limit => 25
    t.string   "map_reference",        :limit => 50
    t.string   "nationality_singular", :limit => 35
    t.string   "nationaiity_plural",   :limit => 35
    t.string   "currency",             :limit => 30
    t.string   "currency_code",        :limit => 3
    t.integer  "population"
    t.string   "title",                :limit => 50
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_acknowledgements", :force => true do |t|
    t.string   "token"
    t.datetime "expire_date"
    t.string   "ack_state"
    t.integer  "email_acknowledgeable_id"
    t.string   "email_acknowledgeable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "featurable_id"
    t.string   "featurable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organisations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "realm_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "organisation_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "product_id"
  end

  create_table "projects_members", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.integer "role_id"
  end

  add_index "projects_members", ["project_id"], :name => "index_projects_members_on_project_id"
  add_index "projects_members", ["user_id"], :name => "index_projects_members_on_user_id"

  create_table "realms", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.integer  "country_id",                 :null => false
    t.string   "name",         :limit => 45, :null => false
    t.string   "code",         :limit => 8,  :null => false
    t.string   "adm1code",     :limit => 4,  :null => false
    t.string   "country_ison", :limit => 4,  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "fulfil_status"
    t.integer  "taskable_id"
    t.string   "taskable_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "gender"
    t.date     "date_of_birth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_stories", :force => true do |t|
    t.string   "name"
    t.string   "role"
    t.string   "goal"
    t.string   "benefit"
    t.integer  "story_points"
    t.integer  "priority"
    t.integer  "feature_id"
    t.integer  "backlog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "salt"
    t.string   "encrypted_password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
