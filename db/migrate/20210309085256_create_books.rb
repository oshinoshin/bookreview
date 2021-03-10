class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.text :title,      null: false
      t.text :review,     null: false
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
