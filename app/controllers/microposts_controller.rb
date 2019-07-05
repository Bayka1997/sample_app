class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = t("controllers.micropost.created")
      redirect_to root_url
    else
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t("controllers.micropost.deleted")
    else
      flash[:danger] = t("controllers.micropost.er_delete")
    end
    redirect_to request.referrer || root_url
  end

  private
    def micropost_params
      params.require(:micropost).permit :content, :picture
    end

    def correct_user
      @micropost = current_user.microposts.find_by_id params[:id]
      redirect_to root_url if @micropost.nil?
    end
end
