# require 'date'

class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.order('completed, priority DESC')
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to root_path
    else
      @tasks = Task.order('completed, priority DESC')
      #need to pass @tasks so the info can be available to the index
      render 'index'
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.completed = true
    @task.date_completed = Time.now
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
