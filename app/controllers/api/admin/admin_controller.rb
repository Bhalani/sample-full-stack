class Api::Admin::AdminController < Api::ApiController
  # before_action :authenticate_user!

  private

  def role
    'admin'
  end
end
