class Api::SessionController < Api::ApiController
  def create
    @current_user = get_user(params[:token])
  end
end
