class CreateBorrows < ActiveRecord::Migration[7.0]
  def change
      create_table :borrows, id: :uuid, default: -> { "gen_random_uuid()" } do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }, type: :bigint
      t.references :book, null: false, foreign_key: { to_table: :books }, type: :uuid
      t.date :due_date

      t.timestamps
    end
  end
end
