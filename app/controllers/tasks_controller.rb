class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.order(priority: :desc)
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.completed = true
    @task.save

    redirect_to root_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:description, :priority)
  end
end
