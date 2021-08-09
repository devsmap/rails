class AddTableCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.belongs_to :state, null: false, foreign_key: true, index: true

      t.string  :name,      null: false
      t.boolean :is_active, default: true
      t.string  :latitude,  null: false
      t.string  :longitude, null: false

      t.timestamps null: false
    end

    add_index :cities, :name
  end
end
