class CreateEdges < ActiveRecord::Migration[5.1]
  def change
    create_table :edges do |t|
      t.references :graph, foreign_key: true
      t.references :initial_vertex, foreign_key: {to_table: :vertices}
      t.references :final_vertex, foreign_key: {to_table: :vertices}
      t.integer :time
      t.integer :distance

      t.timestamps
    end
  end
end
