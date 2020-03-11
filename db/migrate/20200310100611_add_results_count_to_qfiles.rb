class AddResultsCountToQfiles < ActiveRecord::Migration[5.2]
  def self.up
    add_column :qfiles, :results_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :qfiles, :results_count
  end
end
