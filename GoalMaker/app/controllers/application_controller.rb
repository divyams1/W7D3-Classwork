class ApplicationController < ActionController::Base

    def current_user 
        return nil unless session[:session_token]
        @current_user ||= User.find_by(session_token: session[:session_token])
    end 

    def logged_in? 
        !!current_user
    end 

    def log_in(user)
        session[:session_token] = user.reset_session_token
    end 

    def log_out 
        session[:session_token] = User.reset_session_token
        session[:session_token] = nil 
        @current_user = nil 
    end 

    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end 
end
