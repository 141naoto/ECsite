class Public::ProductsController < Public::ApplicationController
	def index
		@products = Product.page(params[:page]).reverse_order.order(release: "DESC")
		@categories = Category.all
		@artists = Artist.all
	end

	def show
		@product = Product.find(params[:id])
		@discs = @product.discs
        @review = Review.new
	end

	def search
		@categories = Category.all
		@artists = Artist.all
		@productfind = Product.search(params[:search])
		# .order(release: "DESC")
	end

	def update
		@product = Product.find(params[:id])
		@product.update(product_params)
		redirect_to product_path(@product.id)
	end

	def destroy
		@product = Product.find(params[:id])
		@product.destroy
		redirect_to admin_products_path
	end

	private
	def product_params
        params.require(:product).permit(:title, :image, :price, :label, :stock, :release, :introduction, :artist_id, category_ids: [], discs_attributes: [:id, :disc_name, :done, :_destroy,tracks_attributes: [:id, :music, :list_num]])
   	end
end


