class Api::UsersController < Api::ApiController
  before_action :authenticate_user!

  def update
    if @current_user.update(daily_calorie_limit: params[:threshold])
      head :ok
    else
      render json: @current_user.errors.to_json, status: :unprocessable_entity
    end
  end
end
