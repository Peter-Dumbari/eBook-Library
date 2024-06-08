class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :book, null: false, foreign_key: { to_table: :books }, type: :uuid
      t.text :image_data

      t.timestamps
    end
  end
end
