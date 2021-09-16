class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.integer :user_id, null: false, foreign_key: true
      t.bigint :distance, null: false
      t.integer :start_id, null: false, foreign_key: true
      t.integer :finish_id, null: false, foreign_key: true
      t.date :day, null: false
      t.timestamps
    end
    add_index :activities, :user_id
    add_index :activities, :start_id
    add_index :activities, :finish_id
    add_index :activities, :day
  end
end
