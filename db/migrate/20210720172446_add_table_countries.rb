class AddTableCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|

      t.boolean :is_active,    default: false
      t.boolean :is_collected, default: false

      t.string :name,        null: false
      t.string :region,      null: false
      t.string :subregion,   null: false
      t.string :latitude,    null: false
      t.string :longitude,   null: false
      t.string :emoji,       null: false
      t.string :google_uule, null: false
      t.string :google_gl,   null: false
      t.string :google_hl,   null: true
      t.string :time_zone,   null: true
      
      t.timestamps null: false
    end

    add_index :countries, :name, unique: true
  end
end
