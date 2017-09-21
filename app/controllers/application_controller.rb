class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def show_404
    render file: "public/404.html", status: :not_found, layout: false
  end
end
