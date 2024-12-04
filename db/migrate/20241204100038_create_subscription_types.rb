class CreateSubscriptionTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :subscription_types do |t|
      t.string :membership_type
      t.decimal :price
      t.integer :duration
      t.text :description
      t.boolean :status

      t.timestamps
    end
  end
end
