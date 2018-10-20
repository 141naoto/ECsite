class ArtistsController < ApplicationController
  def new
    @artist_new = Artist.new
    @artist = Artist.all
  end

  def create
    @artist_new = Artist.new(artist_params)
    @artist_new.save(artist_params)
    redirect_to new_artist_path
  end

  def show
    @artist = Artist.find(params[:id])
    @categories = Category.all
    @artists = Artist.all
  end
  def edit
    @artist_edit = Artist.find(params[:id])
  end

  def update
    @artist_edit = Artist.find(params[:id])
    @artist_edit.update(artist_params)
    redirect_to new_artist_path
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    redirect_to new_category_path
  end

  private
  def artist_params
    params.require(:artist).permit(:artist_name)
  end
end
