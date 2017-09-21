class ProjectsController < ApplicationController
  before_action :find_project, except: [:index, :create]
  def index
    @projects = scope

    respond_to do |format|
      format.html
      format.json do
        render json: @projects
      end
    end
  end

  def show
    render json: @project
  end

  def create
    @project = Project.new create_params

    if @project.save
      render json: @project, status: :created
    else
      render json: @project.errors.details, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(update_params)
      render json: @project
    else
      render json: @project.errors.details, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy

    head :no_content
  end

  private

  def scope
    Project
  end

  def paginate(relation)
    relation.page params[:page]
  end

  def find_project
    @project = scope.lookup params[:id]
    show_404 unless @project
  end

  def create_params
    params.require(:project).permit(:name, :description, :north, :south, :east, :west)
  end

  def update_params
    params.require(:project).permit(:description)
  end
end
