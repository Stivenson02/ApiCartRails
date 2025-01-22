class  AddQuantityToCartItems < ActiveRecord::Migration[7.0]
  def change
    add_column :cart_items, :quantity, :integer,  null: false, default: 0
  end
end
