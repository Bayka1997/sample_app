class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_to user
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
