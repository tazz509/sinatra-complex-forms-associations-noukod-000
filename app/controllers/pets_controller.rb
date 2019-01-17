class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners=Owner.all
    erb :'/pets/new'
  end

  post '/pets' do

    @owner=Owner.find_by(@params[:pet_owner_id])
    @pet = Pet.create(name:@params[:pet_name],owner:@owner)

    if !@params["owner_name"].empty?
      new_owner=Owner.create(name:@params["owner_name"])
      @pet.owner=new_owner
      @pet.save
    end

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet=Pet.find_by_id(@params[:id])
    @owners=Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    # raise params.inspect
    @pet=Pet.find_by_id(@params[:id])
    # @pet.name=@params[:pet_name]
    # @pet.owner=Owner.find_by_id(@params[:pet][:owner_id])
    @pet.update params[:pet]
    #binding.pry

    @pet.owner = Owner.create(@params[:owner]) unless params[:owner][:name].empty?

    @pet.save

    redirect "/pets/#{@pet.id}"

  end
end
