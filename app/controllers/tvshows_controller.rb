class TvshowsController < ApplicationController
  include HTTParty

  def index
    response = HTTParty.get("https://api.themoviedb.org/3/discover/tv?api_key=#{ENV["SECRET_API_KEY"]}&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false")
    @top_shows = response["results"]
  end

  def show
    @tvshow = @top_shows.find(params[:id])
  end

  def search
    response = HTTParty.get("https://api.themoviedb.org/3/search/tv?api_key=#{ENV["SECRET_API_KEY"]}&query=#{params[:query]}&page=1")
    @shows = response["results"]
  end


end
