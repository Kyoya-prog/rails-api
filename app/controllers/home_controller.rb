class HomeController < ApplicationController
  skip_before_action :set_session, only: [:index,:privacy]
  skip_before_action :require_login, only: [:index,:privacy]
  def index
    render html: "hello, world!"
  end

  def privacy
    render html:  "privacy"
  end
end
