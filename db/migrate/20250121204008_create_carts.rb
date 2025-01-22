class CreateCarts < ActiveRecord::Migration[7.2]
  def change
    create_table :carts do |t|
      t.integer :total
      t.integer :quantity_products

      t.timestamps
    end
  end
end
