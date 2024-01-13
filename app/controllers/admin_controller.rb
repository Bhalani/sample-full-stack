class AdminController < ApplicationController
  def index
    render template: 'admin'
  end

  private

  def role
    "admin"
  end
end
