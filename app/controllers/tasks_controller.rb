class TasksController < ApplicationController
    def index
      @tasks = Task.all
    end

    def new
      @task = Task.new
    end

    def create
      Task.create(task_params)
      redirect_to index_task_path
    end



    def show
    end

    def edit
    end

    private
    
    def task_params
        params.require(:task).permit(:name,:content)
    end

end
