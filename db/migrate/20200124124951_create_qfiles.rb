class CreateQfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :qfiles do |t|
      t.string :src, null: false
      t.timestamps
    end
  end
end
