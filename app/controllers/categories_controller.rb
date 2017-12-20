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

  get '/categories/:id/edit' do
  redirect?
    @category = Category.find(params[:id])
    if @category.user_id = current_user.id
      erb :'/categories/edit'
    else
      redirect to "/categories"
  end
end

post '/categories/:id' do
  redirect?
  @category = Category.find(params[:id])

  unless Category.valid_params?(params)
    redirect to "/categories/new"
  end

  @category.update(params)
  @category.poems = params["category"]["poems_id"]
  @category.save
    redirect to "/categories/#{@category.id}"
end

delete '/categories/:id/delete' do
  @category = Category.find(params[:id])
  if logged_in? && @category.user_id == current_user.id
    @category.destroy
    redirect to "/categories"
  else
    redirect "/login"
  end
end

end
