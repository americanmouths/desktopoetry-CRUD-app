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
    redirect to "/categories/#{@category.id}"
    end

  get '/categories/:id' do
    redirect?
    @category = Category.find(params[:id])
    erb :'categories/show'
  end

end
