class AddUserIdToQfiles < ActiveRecord::Migration[5.2]
  def change
    add_reference :qfiles, :user, foreign_key: true
  end
end
