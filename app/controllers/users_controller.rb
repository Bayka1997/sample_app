class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.order(:name).page params[:page]
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash.now[:success] = t("controllers.user.welcome")
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash.now[:success] = t("controllers.user.profile")
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t("controllers.user.delete_s")
    else
      flash[:danger] = t("controllers.user.delete_er")
    end
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = t("controllers.user.please_ln")
      redirect_to login_url
    end

    def correct_user
      @user = User.find_by_id params[:id]
      redirect_to root_url unless @user == current_user
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def load_user
      @user = User.find_by_id params[:id]
      return if @user
      flash[:danger] = t("controllers.user.not_exits")
      redirect_to root_path
    end
end
