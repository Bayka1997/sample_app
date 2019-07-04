class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, only: %i(edit update)
  before_action :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by_email params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t("controllers.password_reset.info")
      redirect_to root_url
    else
      flash.now[:danger] = t("controllers.password_reset.error")
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t("controllers.password_reset.er_pass_empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update reset_digest: nil
      flash[:success] = t("controllers.password_reset.success")
      redirect_to @user
    else
      render :edit
    end
  end

  private
    def get_user
      @user = User.find_by_email params[:email]
      return if @user
      flash[:danger] = t("controllers.password_reset.not_exits")
      redirect_to root_path
    end

    def valid_user
      return if (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
      redirect_to root_url
    end

    def user_params
      params.require(:user).permit :password, :password_confirmation
    end

    def check_expiration
      return unless @user.password_reset_expired?
      flash[:danger] = t("controllers.password_reset.expired")
      redirect_to new_password_reset_url
    end
end
