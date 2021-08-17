class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees, id: :uuid do |t|
      t.text       :name,                   null: false
      t.text       :email,                  null: false
      t.integer    :role,                   default: 0,  null: false
      t.string     :encrypted_password,     default: "", null: false
      t.string     :confirmation_token
      t.datetime   :confirmed_at
      t.datetime   :confirmation_sent_at
      t.string     :reset_password_token
      t.datetime   :reset_password_sent_at
      t.datetime   :remember_created_at
      t.integer    :sign_in_count,          default: 0,  null: false
      t.datetime   :current_sign_in_at
      t.datetime   :last_sign_in_at
      t.text       :current_sign_in_ip
      t.text       :last_sign_in_ip
      t.timestamps null: false
      t.datetime   :deleted_at 
    end

    add_index :employees, :confirmation_token, unique: true, using: :btree
    add_index :employees, :reset_password_token, unique: true, using: :btree
  end
end
