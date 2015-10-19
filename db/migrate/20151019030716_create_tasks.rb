class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.text :description
      t.boolean :completed, default: false
      t.datetime :date_completed
      t.integer :priority

      t.timestamps null: false
    end
  end
end
