class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcasae)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
       params[:session][:remember_me] == '1' ? remember(user) : forget(user) #we can say: else forget(user) because even if we delete the cookie, the session will still exist
      redirect_to user_url(user) #can just say: redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end 
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
