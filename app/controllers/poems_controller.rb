class PoemController < ApplicationController

  get '/poems' do
    redirect?
    @user = current_user
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

    unless Poem.valid_params?(params)
      flash[:error] = "Please do not leave any fields empty"
      redirect to "/poems/new"
    end

    @poem = Poem.create(title: params[:poems][:title], date: params[:poems][:date], content: params[:poems][:content])
    @poem.category = Category.find_or_create_by(name: params[:poems][:category])
    @poem.save
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
     if @poem.user_id == current_user.id
       erb :'/poems/edit'
     else
       redirect to "/poems"
   end
 end

 patch '/poems/:id' do
   redirect?
   @poem = Poem.find(params[:id])

   unless Poem.valid_params?(params) && Category.valid_params?(params)
     flash[:error] = "Please do not leave any fields empty"
     redirect to "/poems/new"
   end

   if logged_in? && @poem.user_id == current_user.id
     @poem.update(title: params[:poems][:title], date: params[:poems][:date], content: params[:poems][:content])
     @poem.category = Category.find_or_create_by(name: params[:poems][:category])
     @poem.save
     flash[:message] = "Succesfully updated your poem"
     redirect to "/poems/#{@poem.id}"
   else
     redirect to "/login"
   end
 end

 delete '/poems/:id/delete' do
   @poem = Poem.find(params[:id])
   if logged_in? && @poem.user_id == current_user.id
     @poem.destroy
     flash[:message] = "Your poem has been deleted"
     redirect to "/poems"
   else
     redirect "/login"
   end
 end
end
