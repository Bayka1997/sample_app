class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id params[:id]
    return if @user
    flash.now[:danger] = t("controllers.user.not_exits")
  end

  def create
    @user = User.new user_params
    if @user.save
      flash.now[:success] = t("controllers.user.welcome")
      redirect_to @user
    else
      render :new
    end
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end
end
