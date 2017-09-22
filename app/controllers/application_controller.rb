class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def pagination(scope)
    {
      total_count: scope.total_count,
      total_pages: scope.total_pages,
      current_page: scope.current_page
    }
  end

  def show_404
    render file: "public/404.html", status: :not_found, layout: false
  end
end
