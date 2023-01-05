class TasksController < ApplicationController
    def index
      @tasks = Task.all
    end

    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params)
      if @blog.save
        redirect_to tasks_path, notice: "ブログを作成しました！"
      else
        render :new
   
    end



    def show
      @task = Task.find(params[:id])
    end

    def edit
    end

    private
    
    def task_params
        params.require(:task).permit(:name,:content)
    end

end
