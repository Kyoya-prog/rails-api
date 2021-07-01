class UsersController < ApplicationController

  skip_before_action :require_login, only: [:create]
  def index
    users = User.all
    render json: {users: users}
  end

  def create
    user = User.new(email:params[:email],password:params[:password])
    status = :ok
    if user.save
      token = Session.create(user)
      status = :created
      render json: {token:token},status:status
    else
      render json:{error:"error"},status:status
    end
  end
end
