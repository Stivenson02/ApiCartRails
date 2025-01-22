class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show update destroy ]

  # GET /carts
  def index
    @carts = Cart.includes(cart_items: :product).all

    render json: @carts.as_json(include: {
    cart_items: {
      include: {
        product: { only: [:name, :price] }  # Seleccionas los atributos del producto
      },
      only: [:product_id, :quantity]  # Incluyes solo el product_id en cart_items
    }
  })
  end

  # GET /carts/1
  def show
    render json: @cart.as_json(include: {
    cart_items: {
      include: {
        product: { only: [:name, :price] }  # Seleccionas los atributos del producto
      },
      only: [:product_id, :quantity]  # Incluyes solo el product_id en cart_items
    }
  })
  end

  # POST /carts
  def create    
    product_items = cart_params
    total = 0
    @cart = Cart.new(quantity_products: product_items.count)
    product_items.each do |product_item|
      product = Product.find(product_item["product_id"])
      cart_item = CartItem.new
      cart_item.product = product
      cart_item.quantity = product_item["quantity"].to_i
      cart_item.cart = @cart
      cart_item.price = product.price * cart_item.quantity
      cart_item.save
      total = total + cart_item.price
    end      

    if @cart.save
      render json: @cart, status: :created, location: @cart
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /carts/1
  def update    
    product_items = cart_params
    total = 0
    product_items.each do |product_item|      
      product = Product.find(product_item["product_id"])
      cart_item = CartItem.find_or_initialize_by(product: product, cart: @cart)
      cart_item.quantity = product_item["quantity"].to_i
      cart_item.cart = @cart
      cart_item.price = product.price * cart_item.quantity
      cart_item.save
      total = total + cart_item.price
    end      

    if @cart.save
      # Incluimos los cart_items y sus productos asociados en la respuesta
      render json: @cart.as_json(include: { cart_items: { include: :product } }), status: :ok
    else
      render json: @cart.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carts/1
  def destroy
    product_id = params[:product_id]
    cart_item = @cart.cart_items.find_by(product_id: product_id)
  
    if cart_item
      if cart_item.quantity > 1
        cart_item.quantity -= 1
        cart_item.price = cart_item.product.price * cart_item.quantity
        cart_item.save
      else
        cart_item.destroy
      end
  
      if @cart.cart_items.empty?
        @cart.destroy
        render json: { message: 'El carrito ha sido eliminado porque no tiene productos.' }, status: :ok
      else
        @cart.total = @cart.cart_items.sum(&:price)
        @cart.save
        render json: {
          id: @cart.id,
          total: @cart.total,
          cart_items: @cart.cart_items.map do |item|
            {
              product_id: item.product_id,
              quantity: item.quantity,
              price: item.price,
              product: {
                id: item.product.id,
                name: item.product.name,
                price: item.product.price
              }
            }
          end
        }, status: :ok
      end
    else
      render json: { error: 'El producto no existe en el carrito.' }, status: :not_found
    end
  end
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.includes(cart_items: :product).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      JSON.parse(params.to_json)["product_items"]
    end
end
