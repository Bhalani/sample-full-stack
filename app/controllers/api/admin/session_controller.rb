class Api::Admin::SessionController < Api::Admin::AdminController
  def create
    @current_user = get_user(params[:token])
  end
end
