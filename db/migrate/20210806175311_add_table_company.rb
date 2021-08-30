class AddTableCompany < ActiveRecord::Migration[6.1]
  def change
    create_table :companies, id: :uuid do |t|
      t.boolean   :is_customer, default: false

      t.string    :name
      t.string    :slug

      t.timestamps
      t.datetime   :deleted_at
    end    

    add_index :companies, :slug, unique: true    
  end
end
