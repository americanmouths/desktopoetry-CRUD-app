class UserController < ApplicationController

  get '/signup' do
  if !logged_in?
    erb :'users/signup'
  else
    redirect to "/users/:slug"
  end
end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    @user = current_user
    erb :'/users/show'
  end

  post '/signup' do
    if !User.valid_params?(params) || !User.valid_username?(username: params[:username])
      flash[:message] = "Please enter a valid username and password"
      redirect to "/signup"
    else
      @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/users/:slug"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    redirect to "/users/:slug" if logged_in?

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/users/#{@user.slug}"
    else
      flash[:message] = "Please provide a valid Username and Passowrd"
      redirect to "/login"
    end
  end

  get '/logout' do
   if logged_in?
     flash[:message]= "You have been successfully logged out"
     session.destroy
     redirect to "/login"
   else
     redirect to "/login"
   end
 end

end
