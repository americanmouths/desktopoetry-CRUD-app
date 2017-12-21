class UserController < ApplicationController

  get '/signup' do
  if !logged_in?
    erb :'users/signup'
  else
    redirect to "/poems"
  end
end

  post '/signup' do
    if !User.valid_params?(params)
      flash[:message] = "Fields cannot be empty"
      redirect to "/signup"
    else
      @user = User.create(:username => params[:username], :password => params[:password], :email => params[:email])
      session[:user_id] = @user.id
      redirect "/poems"
    end
  end

  get '/login' do
    if logged_in?
      redirect to "/poems"
    else
      erb :"/users/login"
    end
  end

  post '/login' do
    redirect to "/poems" if logged_in?

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to "/poems"
    else
      flash[:message] = "Please provide a valid Username and Passowrd"
      redirect to "/login"
    end
  end

  get '/logout' do
   if logged_in?
     flash[:message]= "You have been successfully logged out"
     session.clear
     redirect to "/login"
   else
     redirect to "/login"
   end
 end

end
