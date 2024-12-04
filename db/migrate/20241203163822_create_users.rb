class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email_address, null: false
      t.string :password_digest, null: false
      t.integer :role, default: 0
      t.string :last_name
      t.string :first_name
      t.date :birthdate
      t.string :zip_code
      t.string :town
      t.string :country
      t.string :phone_number
      t.string :occupation
      t.string :specialty
      t.boolean :image_rights
      t.boolean :newsletter
      t.boolean :get_involved

      t.timestamps
    end
    add_index :users, :email_address, unique: true
  end
end
