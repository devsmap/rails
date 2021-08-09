class AddTableCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name,  null: false
      t.references :parent, null: true, foreign_key: { to_table: :categories, on_delete: :cascade }, index: true
      t.string :icon
      t.boolean :is_active, default: false
      
      t.timestamps null: false
    end

    add_index :categories, :name, unique: true    
  end
end
