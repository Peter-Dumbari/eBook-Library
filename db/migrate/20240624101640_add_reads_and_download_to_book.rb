class AddReadsAndDownloadToBook < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :reads, :bigint, default: 0
    add_column :books, :downloads, :bigint, default: 0
  end
end
