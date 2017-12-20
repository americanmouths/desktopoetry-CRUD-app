class PoemController < ApplicationController

  get '/poems' do
    redirect?
      @user = current_user
      @poems = Poem.all
      erb :"/poems/index"
  end

  get '/poems/new' do
    redirect?
    @poems = Poem.all
    @categories = Category.all
    erb :'poems/new'
  end

  post '/poems' do
    redirect?

    unless Poem.valid_params?(params) && Category.valid_params?(params)
      redirect to "/poems/new"
    end

    @poem = Poem.create(title: params[:title], date: params[:date], content: params[:content])
    @poem.category = Category.find_or_create_by(name: params[:name])
    @poem.save
    binding.pry
    redirect to "/poems/#{@poem.id}"
   end

   get '/poems/:id' do
    redirect?
    @poem = Poem.find(params[:id])
    erb :'poems/show'
  end

  get '/poems/:id/edit' do
   redirect?
     @poem = Poem.find(params[:id])
     if @poem.user_id = current_user.id
       erb :'/poems/edit'
     else
       redirect to "/poems"
   end
 end

 patch '/poems/:id' do
   redirect?
   @poem = Poem.find(params[:id])

   unless Poem.valid_params?(params) && Category.valid_params?(params)
     redirect to "/poems/new"
   end

   @poem.update(title: params[:title], date: params[:date], content: params[:content])
   @poem.category = Category.find_or_create_by(name: params[:name])
   @poem.save
     redirect to "/poems/#{@poem.id}"
 end

 delete '/poems/:id/delete' do
   @poem = Poem.find(params[:id])
   if logged_in? && @poem.user_id == current_user.id
     @poem.destroy
     redirect to "/poems"
   else
     redirect "/login"
   end
 end


end
