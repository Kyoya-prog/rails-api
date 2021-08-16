class SessionController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      token = Session.create(user)
      status = :created
    render json: { token: token },status: status
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def check
    render json: { result: "logged in" }, status: :ok
  end
end
