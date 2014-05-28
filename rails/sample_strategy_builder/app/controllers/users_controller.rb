class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def new
		@users = []
		@user = User.new
	end

	def show
  		@user = User.find(params[:id])
  	end

	def create
		@user = User.new(user_params)
  		if @user.valid?
    		flash[:notice] = "Successfully created user."    		
    		redirect_to @user
  		else	
    		render :action => 'new'
  		end
	end

	private

    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
