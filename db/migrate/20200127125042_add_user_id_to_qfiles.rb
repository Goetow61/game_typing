class AddUserIdToQfiles < ActiveRecord::Migration[5.2]
  def change
    add_reference :qfiles, :User, foreign_key: true, null: false
  end
end
