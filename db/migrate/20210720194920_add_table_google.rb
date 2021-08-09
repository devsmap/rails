class AddTableGoogle < ActiveRecord::Migration[6.0]
  def change
    create_table :google do |t|
      t.belongs_to :category,  null: false, foreign_key: true, index: true
      t.belongs_to :state,     null: false, foreign_key: true, index: true

      t.boolean   :is_detailed, default: false

      t.string   :job_id
      t.string   :title
      t.string   :company
      t.string   :city
      t.string   :via
      t.string   :published_at
      t.text     :description
      t.string   :link
      t.string   :token

      t.timestamps null: false
      t.datetime   :deleted_at
      t.string     :deleted_reason
    end  

    add_index :google, :job_id, unique: true    
  end
end
