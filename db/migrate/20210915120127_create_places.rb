class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :address, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.timestamps
    end
    add_index :places, :address
    add_index :places, [:latitude, :longitude], unique: true
  end
end
