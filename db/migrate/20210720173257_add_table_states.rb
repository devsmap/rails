class AddTableStates < ActiveRecord::Migration[6.0]
  def change
    create_table :states do |t|
      t.belongs_to :country, null: false, foreign_key: true, index: true

      t.string  :name,        null: false
      t.string  :state_code,  null: false
      t.boolean :is_active,   default: false
      t.string  :latitude,    null: false
      t.string  :longitude,   null: false
      t.string  :google_uule, null: false
      
      t.timestamps null: false
    end

    add_index :states, :name, unique: true
  end
end
