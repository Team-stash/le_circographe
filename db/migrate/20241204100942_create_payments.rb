class CreatePayments < ActiveRecord::Migration[8.0]
  def change
    create_table :payments do |t|
      t.references :user_membership, foreign_key: true
      t.string :payment_method
      t.decimal :amount
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
