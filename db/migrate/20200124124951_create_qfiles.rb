class CreateQfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :qfiles do |t|
      t.string :title, null: false
      t.text :overview
      t.string :src, null: false
      t.integer :category, null: false
      t.timestamps
    end
  end
end
