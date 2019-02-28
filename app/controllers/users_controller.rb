class UsersController < ApplicationController

    def new
        session[:session_token] = "hello"
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in_user!(@user)
        else
            flash[:error] = @user.errors.full_messages
            render :new
        end

    end

    private
    def user_params
        return params.require(:user).permit(:username, :password)
    end
end