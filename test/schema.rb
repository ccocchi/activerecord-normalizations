ActiveRecord::Schema.define(version: 2021_06_21_98736) do
  create_table "users", force: :cascade do |t|
    t.string "name", limit: 255
    t.string "pseudo", limit: 255
  end
end
