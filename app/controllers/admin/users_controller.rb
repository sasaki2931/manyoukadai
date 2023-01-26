class Admin::UsersController < ApplicationController
    before_action :admin_user

    def index
        @user = User.all.includes(:tasks)
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(admin_user_params)
        if @user.save
          redirect_to admin_users_path
        else
          render :new
        end
    end

    def update
        @user = User.find(params[:id])
        if @user.update(admin_user_params)
          redirect_to admin_users_path
        else
          render :edit
        end
    end

    def show
      @user = User.find(params[:id])
      @tasks = @user.tasks.all.includes(:user)
      #@tasks = Task.all.includes(:user)
    end

    def edit
        @user = User.find(params[:id])
    end


    def destroy
        @user = User.find(params[:id])
          @user.destroy
          flash[:danger] = "ユーザを削除しました"
          redirect_to admin_users_path
    end

    private

    def admin_user_params
        params.require(:user).permit(:name,:email, :password,:password_confirmation,:admin)
    end

    def  admin_user
      unless current_user.admin?
        redirect_to tasks_path 
        flash[:danger] = "管理者以外アクセスできません"
      end
    end
end

