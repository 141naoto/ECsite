class Public::UsersController < Public::ApplicationController
	before_action :correct_user, only:[:edit, :update, :destroy, :show, :create_cart]

	def correct_user
	    unless user_signed_in? || admin_signed_in?
	      redirect_to root_path
	    end
  	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end


	def update
		user = User.find(params[:id])
    	user.update(user_params)
    	redirect_to user_path(user), success: 'お客様情報が更新されました'
	end

	def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, danger: '退会しました'
  	end

	private
    def user_params
        params.require(:user).permit(:name, :name_kana, :email, :phone, :post_code, :address)
    end

end
