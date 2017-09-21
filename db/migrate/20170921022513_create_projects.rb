class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :permalink, null: false, index: true
      t.string :description
      t.decimal :north, null: false, index: true
      t.decimal :south, null: false, index: true
      t.decimal :east, null: false, index: true
      t.decimal :west, null: false, index: true

      t.timestamps
    end
  end
end
