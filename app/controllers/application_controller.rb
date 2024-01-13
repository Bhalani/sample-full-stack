class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  around_action :set_locale_from_url
  rescue_from Exception, with: :render_error
  before_action :get_timezone

  def index
    render template: 'application'
  end

  def authenticate_user!
    return true if user_signed_in?

    render json: { error: "Invalid Token" }, status: :unauthorized
  end

  def user_signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= get_user
  end

  private

  def get_user(user_id = nil)
    header = request.headers["Authorization"]
    user_id = header.split(" ").last if header && !user_id
    User.find_by(token: user_id, role: role)
  end

  def role
    "user"
  end

  def render_error(e)
    if e.class.name == "ActiveRecord::RecordNotFound"
      render json: {success: false, error: "Not found"}.to_json, status: 404
    else
      render json: {success: false, error: "Internal server error"}.to_json, status: 500
    end
  end

  def get_timezone
    @request_timezone = request.headers["Timezone"]
  end
end
