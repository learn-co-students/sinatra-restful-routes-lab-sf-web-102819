require "pry"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # Renders index page with all recipes
  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  # Renders a new path to create new recipe instance
  get '/recipes/new' do
    @recipe = Recipe.new
    erb :new
  end

  # Creates/posts a new recipe in the DB then redirect toe that recipe id path
  post '/recipes' do
    # binding.pry

    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{ @recipe.id }"
  end
  
  # Shows/diplays
  get "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  # Edit the recipe id by rendering the edit view
  get "/recipes/:id/edit" do
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(params[:recipe])
    redirect "/recipes/#{ @recipe.id}"
  end

  delete '/recipes/:id' do
    Recipe.destroy(params[:id])
    redirect "/recipes"
  end
end
