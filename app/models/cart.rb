# == Schema Information
#
# Table name: carts
#
#  id                :bigint           not null, primary key
#  total             :integer
#  quantity_products :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Cart < ApplicationRecord

  has_many :cart_items, :class_name => 'CartItem', foreign_key: :cart_id

  before_save :calculate_total
  before_save :calculate_quantity

  private

  def calculate_total
    self.total = cart_items.includes(:product).sum { |item| item.product.price * item.quantity }
  end

  def calculate_quantity    
    self.quantity_products = cart_items.sum { |item| item.quantity }
  end
end
