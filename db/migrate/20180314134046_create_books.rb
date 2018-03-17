class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :name
      t.string :author
      t.integer :value
      t.date   :release_date

      t.timestamps
    end
  end
end