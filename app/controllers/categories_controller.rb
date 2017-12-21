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
      flash[:error] = "Please do not leave any fields empty"
      redirect to "/categories/new"
    end
    @category = Category.create(params[:category][:name])
    params[:category][:poems].each do |poem_data|
      poem = Poem.find_or_create_by(poem_data)
      poem.category = @category
      poem.save
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
    if @category.user_id == current_user.id
      erb :'/categories/edit'
    else
      redirect to "/categories"
  end
end

patch '/categories/:id' do
  redirect?
  @category = Category.find(params[:id])

  unless Category.valid_params?(params)
    flash[:error] = "Please do not leave any fields empty"
    redirect to "/categories/new"
  end

  if logged_in? && @category.user_id == current_user.id
      @category.update(params[:category][:name])
      params[:category][:poems].each do |poem_data|
        poem = Poem.find_or_create_by(poem_data)
        poem.category = @category
        poem.save
      end
        @category.save
        flash[:message] = "The category has been updated"
        redirect to "/categories/#{@category.id}"
    else
      redirect "/login"
    end
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
