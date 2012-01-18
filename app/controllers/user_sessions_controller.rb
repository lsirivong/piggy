class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]
  def new
    @user = User.new
  end
  
  def create
    respond_to do |format|
      if @user = login(params[:email], params[:password])
        format.html { redirect_back_or_to(:root, :notice => 'Login successful.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { flash.now[:alert] = "Login failed."; render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
    
  def destroy
    logout
    redirect_to(new_user_session_path, :notice => 'Logged out!')
  end
end
