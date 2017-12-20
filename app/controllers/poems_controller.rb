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

    unless Poem.valid_params?(params)
      redirect to "/poems/new"
    end

    @poem = Poem.create(title: params[:title], date: params[:date], content: params[:content])
    @poem.category = Category.find_or_create_by(name: params[:category])
    @poem.save
    binding.pry
    redirect to "/poems/#{@poem.id}"
   end

   get '/poems/:id' do
    redirect?
    @poem = Poem.find(params[:id])
    erb :'poems/show'
  end


end
