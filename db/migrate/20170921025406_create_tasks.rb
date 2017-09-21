class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :project
      t.string :name, null: false
      t.decimal :lat
      t.decimal :lon
      t.boolean :complete, null: false

      t.timestamps
    end
  end
end
