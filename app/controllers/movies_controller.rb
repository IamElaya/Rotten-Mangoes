class MoviesController < ApplicationController
  
  def index
    @movie = Movie.new

    @movies = Movie.where("title LIKE ?", "%#{params[:title]}%")
                   .where("director LIKE ?", "%#{params[:director]}%")

    case params[:runtime_in_minutes]
    
    when "Under90"
      @movies = @movies.Under90
    when "90 to 120"
      @movies = @movies.Between90and120
    when "Over120"
      @movies = @movies.Over120
    else
      @movies 
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)
    
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
    :title, :release_date, :director, :runtime_in_minutes, :poster, :description
    )
  end

end
