class AddTableJob < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs, id: :uuid do |t|
      t.belongs_to :category, null: false, foreign_key: true, index: true
      t.belongs_to :company,  null: false, foreign_key: true, index: true, type: :uuid, on_delete: :cascade
      t.belongs_to :city,     null: false, foreign_key: true, index: true

      t.boolean   :is_active, default: false

      t.string    :title
      t.text      :description      
      t.string    :via
      t.string    :link
      t.datetime  :published_at
      t.string    :time_zone      
      t.string    :gogole_job_id     

      t.timestamps
      t.datetime   :deleted_at
      t.string     :deleted_reason
    end    

    add_index :jobs, :gogole_job_id, unique: true    
  end
end
