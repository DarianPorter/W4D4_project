class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?, :log_in_user!

    def current_user
        return User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        # sesions[:session_token] == current_user.session_token
        !!current_user
    end

    def log_in_user!(user)
        user.reset_session_token
        session[:session_token] = user.session_token
    end

    def log_out!(user)
        session[:session_token] = nil
        user.reset_session_token
    end
end
