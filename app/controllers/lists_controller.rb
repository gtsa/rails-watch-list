class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    bookmarks = Bookmark.where(list_id: @list.id)
    movies = bookmarks.map do |bookmark|
      Movie.find(bookmark.movie_id)
    end
    @bookmarks_movies = bookmarks.zip(movies)
  end

  def new
    @list = List.new(params[:id])
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
