class CreateVertices < ActiveRecord::Migration[5.1]
  def change
    create_table :vertices do |t|
      t.string :name

      t.timestamps
    end
  end
end
