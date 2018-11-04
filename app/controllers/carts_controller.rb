class CartsController < ApplicationController
  before_action :correct_user

  def correct_user
      unless user_signed_in? || admin_signed_in?
        redirect_to root_path
      end
  end

  def add_item
    cart = Cart.where(user_id: current_user.id).last
    cart_item = cart.cart_items.find_by(product_id: params[:cart_id])
    if cart_item.nil?
      cart_item = CartItem.new
      cart_item.cart_id = cart.id
      cart_item.product_id = params[:cart_id]
      quantity = params[:product][:stock].to_i
      cart_item.quantity = quantity
      product = Product.find(params[:cart_id])
      stock = product.stock
    else
      quantity = cart_item.quantity + params[:product][:stock].to_i
      cart_item.quantity = quantity
      stock = cart_item.product.stock
    end
    if quantity <= stock
         cart_item.save
         redirect_to root_path, success: 'カートに商品が追加されました'
    else
        @message = "在庫は" + cart_item.product.stock.to_s + "個です"
        redirect_to product_path(cart_item.product.id), alert: @message
    end
  end

  def show
     @cart = Cart.where(user_id: current_user.id).last
  end

  def delete_item
    cart_item = CartItem.find(params[:id])
    cart_item.cart_id = current_user.carts.where(user_id: current_user.id).last.id
    cart_item.destroy
    redirect_to cart_path(current_user.carts.where(user_id: current_user.id).last.id)
  end

  def update_item
    cart = current_user.carts.where(user_id: current_user.id).last
    cart_item = CartItem.find_by(cart_id: cart.id, id: params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_path(current_user.carts.where(user_id: current_user.id).last.id)
  end

private
    def cart_params
        params.require(:cart).permit(:user_id)
    end
    def cart_item_params
        params.require(:cart_item).permit(:quantity)
    end
end