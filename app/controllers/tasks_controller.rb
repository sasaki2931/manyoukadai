class TasksController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_task, only: [:show, :edit, :update,:destroy]
  def index
    #binding.irb
    @tasks = current_user.tasks.order(created_at: "DESC").page(params[:page])
    if params[:sort_expired] == "true"
      @tasks = current_user.tasks.order(deadline: "DESC").page(params[:page])
    end
    
    if params[:sort_rank] == "true"
      @tasks = current_user.tasks.order(rank: "DESC").page(params[:page])
    end
    if params[:task].present?
      @tasks = @tasks
      .status_seach(params[:task][:status])
      .name_seach(params[:task][:title])
        #if params[:seach][:status].present? && params[:seach][name].present?
         # @tasks = @tasks.where('name LIKE ? AND status LIKE?', "%#{params[:search]}%")
        #elsif params[:seach][:status].present?
          #@tasks = @tasks.where(status: params[:status])
        #else
          #@tasks = @tasks.where('name LIKE ?', "%#{params[:search]}%")
        #end
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
      params.require(:task).permit(:name,:content,:deadline,:status,:rank)
    end

    def set_task
      @task = Task.find(params[:id])
    end
end
