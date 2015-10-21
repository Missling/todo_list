class TasksController < ApplicationController
  skip_before_filter  :verify_authenticity_token, only: [:twilio_action]

  def index
    @task = Task.new
    @tasks = Task.order('completed, priority DESC')
  end

  def twilio_action
    message = params[:Body].split(",")
    description = message.first
    priority = message.last

    if description == 'Show'
      tasks = Task.where(completed: false)

      if tasks.any?
        list = tasks.map(&:description)
        render xml: twilio_message(list.join(", "))
      else
        render xml: twilio_message("Todo list is empty") 
      end
    else
      priority = 1 if !(1..5).include?(priority)

      task = Task.new(
        description: description,
        priority: priority
      )

      if task.save
        render xml: twilio_message("#{description} has been added to your todo list" )  
      end
    end
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

  def twilio_message(message)
    "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>
      <Response>
        <Message>#{message}</Message>
      </Response>"
  end
end
