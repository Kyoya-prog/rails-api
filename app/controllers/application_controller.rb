class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound,with: :record_not_found
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :set_session
  before_action :require_login
  skip_before_action :set_session, only: [:hello]
  skip_before_action :require_login, only: [:hello]

  @current_user = {}

  def hello
    render html: "hello, world!"
  end

  def require_login
    render json: { error: @current_user }, status: :unauthorized if @current_user.empty?
  end

  def record_not_found
    render json: {error:{code:Settings.error_codes.record_not_found,message: "record not found"}}
  end

  private
  def set_session
    #  リクエストヘッダに 'Authorization: Token hogehoge' がセットされていた場合に、トークン hogehoge を取り出せる
    authenticate_with_http_token do |token,options|
      @current_user = Session.get(token)
    end
  end
end
