class CreateVertices < ActiveRecord::Migration[5.1]
  def change
    create_table :vertices do |t|
      t.string :nome

      t.timestamps
    end
  end
end
