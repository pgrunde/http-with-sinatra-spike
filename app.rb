# must type 'rackup' to run this code (layers: Web brick > Rack > Sinatra > My Code)
# things in initialize are only created on the loading of the server

require "sinatra/base"

class MyApp < Sinatra::Application

  def initialize
    super
    @items = ["Item 1", "Item 2", "Item 3"]
  end

  get "/" do
    erb :root, :locals => { :items => @items }
  end

  get "/grumblepugs" do
    erb :grumblepugs
  end

  get "/items" do
    erb :items, :locals => { :items => @items }
  end

  get "/items/new" do
    erb :new_item, :locals => { :items => @items }
  end

  post "/items/form_processing" do
    data = params[:item_added]
    @items.push(data)
    erb :items, :locals => { :items => @items }
  end

  get "/items/:id" do
    # this is called 'named parameters' or 'path parameters'
    identifier = params[:id].to_i
    "Showing #{@items[identifier]}: <a href='/items/#{identifier}/edit'>Edit Item</a>"
  end

  get "/items/:id/edit" do
    identifier = params[:id].to_i
    erb :item_edit, :locals => { :items => @items, :iden => identifier }
  end

  post "/items/:id/edit" do
    identifier = params[:id].to_i
    data = params[:item_changed]
    @items[identifier] = data
    erb :items, :locals => { :items => @items }
  end

  post "/items/:id/delete" do
    identifier = params[:id].to_i
    @items.delete_at(identifier)
    erb :items, :locals => { :items => @items }
  end

  run! if app_file == $0
end
