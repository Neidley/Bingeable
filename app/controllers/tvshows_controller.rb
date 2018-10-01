class TvshowsController < ApplicationController
  include HTTParty
  before_action :populate_showlist, only: [:index]

  def populate_showlist
    @top_shows = []

    5.times do |t|
      response = HTTParty.get("https://api.themoviedb.org/3/discover/tv?api_key=#{ENV["SECRET_API_KEY"]}&language=en-US&sort_by=popularity.desc&page=#{t + 1}&timezone=America%2FNew_York&include_null_first_air_dates=false")
      response["results"].each do |show|
        @top_shows.push(show)
      end
    end
  end


  def index

    @random_message = [
      "...tv is beter with tacos. and we're fresh out of tacos.",
      "...or you could watch 'The Office' for the millienth time?",
      "...spoiler-free since '93.",
      "...we're gonna need a bigger screen.",
      "...couch, blanket, bff, check. check. check.",
      "...number 100 will shock you!...jk couldn't resist",
      "...can we order a pizza?",
      "...I saved girl scout cookies for this exact moment.",
      "...not your common tv guide. now battery operated!",
      "...recommended by 9 out of 10 couch potatoes!",
      "...Smell-O-Vision coming soon.",
      "...because watching people cook never gets old.",
      "...you simply must watch [insert show!]"
    ]

  end

  def show
    @show = {}
    response = HTTParty.get("https://api.themoviedb.org/3/tv/#{params[:tv_id]}?api_key=#{ENV["SECRET_API_KEY"]}")

    if response["poster_path"].nil?
      @show["poster_path_url"] = "error_image.png"
    else
      @show["poster_path_url"] = "https://image.tmdb.org/t/p/original#{response["poster_path"]}"
    end
    @show["name"] = response["name"]
    @show["network_tag_url"] = "https://image.tmdb.org/t/p/original#{response["networks"][0]["logo_path"]}" unless response["networks"].empty?
    @show["created_by"] = response["created_by"][0]["name"] unless response["created_by"].empty?
    @show["number_of_seasons"] = response["number_of_seasons"].to_s unless response["number_of_seasons"].nil?
    @show["number_of_episodes"] = response["number_of_episodes"].to_s unless response["number_of_episodes"].nil?
    @show["genres"] = response["genres"][0]["name"] unless response["genres"].empty?
    @show["type"] = response["type"] unless response["type"].nil?
    @show["origin_country"] = response["origin_country"][0] unless response["origin_country"].empty?
    @show["first_air_date"] = self.fix_date(response["first_air_date"]) unless response["first_air_date"].nil?
    @show["last_air_date"] = self.fix_date(response["last_air_date"]) unless response["last_air_date"].nil?
    @show["overview"] = response["overview"] unless response["overview"].nil?
    @show["justwatch_url"] = "https://www.justwatch.com/us/search?q=#{response['name']}"
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
