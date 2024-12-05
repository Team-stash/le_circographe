class AddPolymorphicAssociationToPayments < ActiveRecord::Migration[8.0]
  def change
    change_table :payments do |t|
      t.references :payable, polymorphic: true, null: false
  end
end
