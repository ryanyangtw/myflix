class SessionsController < ApplicationController
  
  def new
    redirect_to home_path if current_user
  end

  def create

    # Since Rails 4, .find_by is preferred method for searching a single record. .where(args).first is less effective.
    # user = User.where(email: params[:email]).first
    user = User.find_by(email: params[:email])


    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'You are signed in, enjoy!'
    else
      flash[:error] = "Invalid email or password."
      redirect_to sign_in_path
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are signed out."
  end

end