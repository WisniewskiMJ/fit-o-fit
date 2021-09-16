class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.bigint :distance, null: false
      t.integer :start, null: false, foreign_key: true
      t.integer :finish, null: false, foreign_key: true
      t.date :day, null: false
      t.timestamps
    end
    add_index :activities, :start
    add_index :activities, :finish
    add_index :activities, :day
  end
end
