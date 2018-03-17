class AddTitleToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :url, :string
    add_column :books, :image_url, :string
  end
end
