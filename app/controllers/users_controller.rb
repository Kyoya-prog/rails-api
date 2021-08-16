class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid,with: :error422
  skip_before_action :require_login, only: [:create]
  def index
    users = User.all
    render json: {users: users}
  end

  def create
    @user = User.new(email:params[:email].downcase,password:params[:password])
    @user.save!
    token = Session.create(@user)
    render json: {token:token},status: :ok
  end

  def error422(err)
    class_name = err.record.class.name.underscore
    active_model_errors = err.record.errors
    error = {}
    active_model_errors.details.each do |attribute, attribute_errors|
      attribute_errors.each do |error_info|
        # エラーコードとエラーメッセージをセットにするため、full_messagesではなく
        # generate_messageとfull_messageを使ってエラーメッセージを生成している
        error_key = error_info.delete(:error)
        message = active_model_errors.generate_message(
          attribute, error_key, error_info.except(*ActiveModel::Callbacks),
          )

        error =
          {
            code: Settings.error_codes.models.send(class_name)&.send(attribute)&.send(error_key) ||
              Settings.error_codes.unprocessable_entity, # error_codesにて定義のないエラーの場合、汎用的なエラーコードを返す
            message: active_model_errors.full_message(attribute, message),
          }
      end
    end

    render json: { code:error[:code],message:error[:message]}, status: :unprocessable_entity
  end
end