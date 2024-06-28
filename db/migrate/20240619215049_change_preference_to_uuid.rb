class ChangePreferenceToUuid < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :preference, :uuid
  end
end
