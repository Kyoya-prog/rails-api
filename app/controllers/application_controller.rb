class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :set_session
  before_action :require_login

  @current_user = {}

  def require_login
    render json: { error: @current_user }, status: :unauthorized if @current_user.empty?
  end

  private
  def set_session
    #  リクエストヘッダに 'Authorization: Token hogehoge' がセットされていた場合に、トークン hogehoge を取り出せる
    authenticate_with_http_token do |token,options|
      @current_user = Session.get(token)
    end
  end
end
