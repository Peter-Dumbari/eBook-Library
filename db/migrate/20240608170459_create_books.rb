class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.string :title
      t.string :author
      t.text :description
      t.references :category, null: false, foreign_key: { to_table: :categories }, type: :uuid      
      t.boolean :recommended

      t.timestamps
    end
  end
end
