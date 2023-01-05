class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]
    def index
      @tasks = Task.all
    end

    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params)
      if params[:back]
        render :new
      else
      if @blog.save
        redirect_to tasks_path, notice: "ブログを作成しました！"
      else
        render :new
   
    end



    def show
      
    end

    def edit

    end

    def destroy
      @task.destroy
      redirect_to tasks_path, notice:"ブログを削除しました！"
    end


    def update
      if @task.update(task_params)
        redirect_to tasks_path, notice: "taskを編集しました！"
      else
        render :edit
      end
    end

    def confirm
      @task = Task.new(task_params)
      render :new if @task.invalid?
    end

    private
    
    def task_params
        params.require(:task).permit(:name,:content)
    end

    def set_task
      @task = Task.find(params[:id])
    end

end
