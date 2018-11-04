class Admin::UsersController < Admin::ApplicationController
	before_action :correct_user, only:[:index, :show]

	def correct_user
	    unless admin_signed_in?
	      redirect_to root_path
	    end
  	end
	def index
		@users = User.with_deleted.all
	end

	def show
		@product_new = Product.new
		@disc = @product_new.discs.build
  		@track = @disc.tracks.build
	end
end
