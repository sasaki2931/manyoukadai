class Admin::UsersController < ApplicationController
    #before_action :admin_user

    def index
        @user = User.all.order("created_at DESC")
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

    def updeate
        @user = User.find(params[:id])
        if @user.update(admin__user_params)
          redirect_to admin_users_path, notice: "ユーザーを編集しました！"
        else
          render :edit
        end
    end

    def show
      @user = User.find(params[:id])
      @tasks = Task.all.includes(:user)
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
        params.require(:user).permit(:name,email, :password,:password_confirmation)
    end

    #def admin_user
        #redirect_to(root_path) unless current_user.admin?
    #end
end
