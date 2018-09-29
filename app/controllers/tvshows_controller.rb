class TvshowsController < ApplicationController
  include HTTParty


  def index
    @top_shows = []

    5.times do |t|
      response = HTTParty.get("https://api.themoviedb.org/3/discover/tv?api_key=#{ENV["SECRET_API_KEY"]}&language=en-US&sort_by=popularity.desc&page=#{t + 1}&timezone=America%2FNew_York&include_null_first_air_dates=false")
      response["results"].each do |show|
        @top_shows.push(show)
      end
    end

  end

  def show
    @show = {}
    response = HTTParty.get("https://api.themoviedb.org/3/tv/#{params[:tv_id]}?api_key=#{ENV["SECRET_API_KEY"]}")

    @show["poster_path_url"] = "https://image.tmdb.org/t/p/original#{response["poster_path"]}"
    @show["original_name"] = response["original_name"] || "N/A"
    @show["network_tag_url"] = "https://image.tmdb.org/t/p/original#{response["networks"][0]["logo_path"]}" || "N/A"
    @show["created_by"] = response["created_by"][0]["name"] || "N/A"
    @show["number_of_seasons"] = response["number_of_seasons"].to_s || "N/A"
    @show["number_of_episodes"] = response["number_of_episodes"].to_s || "N/A"
    @show["genres"] = response["genres"][0]["name"] || "N/A"
    @show["type"] = response["type"] || "N/A"
    @show["origin_country"] = response["origin_country"][0] || "N/A"
    @show["first_air_date"] = self.fix_date(response["first_air_date"]) || "N/A"
    @show["last_air_date"] = self.fix_date(response["last_air_date"]) || "N/A"
    @show["overview"] = response["overview"] || "N/A"
    @show["justwatch_url"] = "https://www.justwatch.com/us/search?q=#{@show["original_name"]}" || "N/A"
  end

  def search
    response = HTTParty.get("https://api.themoviedb.org/3/search/tv?api_key=#{ENV["SECRET_API_KEY"]}&query=#{params[:query]}&page=1")
    @shows = response["results"]
  end

  #used on lines 30-31 to format air_dates
  #from YYYY-MM-DD to MM-DD-YYYY
  def fix_date(date)
    result = date.split("-")
    temp = result[0]
    result[0] = result[1]
    result[1] = result[2]
    result[2] = temp
    result.join("-")
  end

end
