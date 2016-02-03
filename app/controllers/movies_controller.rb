class MoviesController < ApplicationController
  
  def index
    if params[:title]
      @movies = Movie.where("title LIKE ?", "%#{params[:title]}%")
    elsif params[:director]
      @movies = Movie.where("director LIKE ?", "%#{params[:director]}%")
    elsif params[:runtime_in_minutes] == "Under90"
      @movies = Movie.where("runtime_in_minutes > ?", 90)
    elsif params[:runtime_in_minutes] == "90 to 120"
      @movies = Movie.where("runtime_in_minutes > ? AND runtime_in_minutes < ?", 90, 120)
    elsif params[:runtime_in_minutes] == "Over120"
      @movies = Movie.where("runtime_in_minutes > ?", 120)
    else
      @movies = Movie.all
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
