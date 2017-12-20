require 'rack/flash'
class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "poetryisthesecret"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def redirect?
      if !logged_in?
        redirect to "/login"
      end
    end
  end

  get '/' do
    erb :'index'
  end

end
