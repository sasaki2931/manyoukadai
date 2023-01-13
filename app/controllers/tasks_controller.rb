class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update,:destroy]
    def index
      if params[:sort_expired] == true
        @tasks = Task.all.order(deadline: "DESC")
      else 
        @tasks = Task.all.order(created_at: "DESC")
      end
    end

    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_params)
      if params[:back]
        render :new
      else
        if @task.save
          redirect_to tasks_path, notice: "ブログを作成しました！"
        else
          render :new
        end
      end
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
    end
  

    private
    
    def task_params
      params.require(:task).permit(:name,:content)
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
