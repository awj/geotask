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
    respond_to do |format|
      format.html do
        render file: "public/404.html", status: :not_found, layout: false
      end

      format.json do
        render json: { "base" => [{ "error" => "not_found" }] },
               status: :not_found
      end
    end
  end
end
