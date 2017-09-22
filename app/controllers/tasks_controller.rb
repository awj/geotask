class TasksController < ApplicationController
  before_action :find_project
  before_action :find_task, except: [:index, :create]

  def index
    tasks = find_tasks

    render json: tasks,
           meta: pagination(tasks),
           each_serializer: TaskSerializer
  end

  def show
    render json: @task
  end

  def create
    task = scope.build create_params

    if task.save
      render json: task, status: :created
    else
      render json: task.errors.details, status: :unprocessable_entity
    end
  end
  
  def update
    if @task.update update_params
      render json: @task
    else
      puts @task.errors.details
      render json: @task.errors.details, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end
  
  private

  def update_params
    params.require(:task).permit(:name, :lat, :lon, :complete)
  end

  def create_params
    update_params
  end

  def scope
    @project.tasks
  end

  def find_tasks
    scope.by_priority.page params[:page]
  end

  def find_task
    @task = scope.find_by id: params[:id]
    show_404 if @task.blank?
  end
  
  def find_project
    @project = Project.lookup params[:project_id]
    show_404 if @project.blank?
  end
end
