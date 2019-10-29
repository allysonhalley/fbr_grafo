class CreateWays < ActiveRecord::Migration[5.1]
  def change
    create_table :ways do |t|
      t.text :vertices_list
      t.text :edges_list
      t.integer :total_distance
      t.integer :total_time

      t.timestamps
    end
  end
end
