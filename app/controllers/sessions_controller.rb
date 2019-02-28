class SessionsController < ApplicationController
    def create 
        @user = User.find_by_credentials(sessions_params[:username], sessions_params[:password])
        if @user.nil?
            flash[:error] = @user.errors.full_messages
        else 
            log_in_user!(@user)
            # render plain: "logged in"
            render json: @user
        end
    end

    def new
        render :new
    end

    def destroy
        @user = User.find_by_credentials(sessions_params[:username], sessions_params[:password])
        log_out!(@user)
        render :new
    end

    private
    def sessions_params
        return params.require(:user).permit(:username, :password)
    end

end 