# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_06_24_101640) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.text "description"
    t.uuid "category_id", null: false
    t.boolean "recommended"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "file_url"
    t.bigint "reads", default: 0
    t.bigint "downloads", default: 0
    t.index ["category_id"], name: "index_books_on_category_id"
  end

  create_table "borrows", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.uuid "book_id", null: false
    t.date "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_borrows_on_book_id"
    t.index ["user_id"], name: "index_borrows_on_user_id"
  end

  create_table "categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "book_id", null: false
    t.text "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_images_on_book_id"
  end

  create_table "reservations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.uuid "book_id", null: false
    t.date "reserved_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_reservations_on_book_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.string "jti"
    t.uuid "preference"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "books", "categories"
  add_foreign_key "borrows", "books"
  add_foreign_key "borrows", "users"
  add_foreign_key "images", "books"
  add_foreign_key "reservations", "books"
  add_foreign_key "reservations", "users"
end
