class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = t("controllers.session.message")
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = t("controllers.session.err")
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
