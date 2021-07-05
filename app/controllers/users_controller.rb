class UsersController < ApplicationController

  skip_before_action :require_login, only: [:create]
  def index
    users = User.all
    render json: {users: users}
  end

  def create
    user = User.new(email:params[:email].downcase,password:params[:password])
    if user.save
      token = Session.create(user)
      render json: {token:token},status: :ok
    else
      response_bad_request
    end
  end
end
