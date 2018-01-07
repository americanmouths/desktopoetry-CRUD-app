class UserController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to "/users/:slug"
    end
  end

  get '/users/:slug' do
    redirect?
    @user = User.find_by_slug(params[:slug])
  if @user == current_user
    erb :'/users/show'
  else
    redirect to "/testing"
  end
end

  post '/signup' do
    if !User.valid_params?(params) || User.taken_username?(username: params[:username])
      flash[:message] = "That username is already taken, please select another. Do not leave any fields empty."
      redirect '/'
    else
      @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    end
  end

  get '/login' do
    if logged_in?
      @user = current_user
      redirect to "/users/#{@user.slug}"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/users/#{@user.slug}"
    else
      flash[:message] = "Please provide a valid Username and Password"
      erb :"users/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "You have been successfully logged out"
      erb :"/index"
    else
      session.clear
      redirect to "/login"
    end
  end

end
