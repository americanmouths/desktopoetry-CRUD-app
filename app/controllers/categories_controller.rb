class CategoryController < ApplicationController
  get '/categories' do
    redirect?
    @user = current_user
    @categories = Category.all
    erb :"/categories/index"
  end

  get '/categories/new' do
    redirect?
      @categories = Category.all
      @poems = Poem.all
      erb :'categories/new'
  end

  post '/categories' do
    redirect?
    unless Category.valid_params?(params)
      redirect to "/categories/new"
    end
    @category = Category.create(params)
    @category.poems = Poem.find_or_create_by(params["category"]["poems_id"])
    redirect to "/categories/#{@category.id}"
    end
end
