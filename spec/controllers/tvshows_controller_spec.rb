require 'rails_helper'
require 'capybara/rspec'

RSpec.describe TvshowsController, type: :controller do
  include HTTParty

  describe "GET #index" do
    it "renders the index template" do
        get :index
        expect(response).to render_template("index")
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "should retrieve 100 shows total from API" do
      get :index
      expect(assigns(:top_shows).count).to eq 100
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { tv_id: 1418 }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: { tv_id: 1418 }
      expect(response).to render_template :show
    end

    it "should properly assign show poster to show['poster_path_url']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["poster_path_url"]).to eq "https://image.tmdb.org/t/p/original/ooBGRQBdbGzBxAVfExiO8r7kloA.jpg"
    end

    it "should properly assign show name to show['name']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["name"]).to eq "The Big Bang Theory"
    end

    it "should properly assign network logo to show['network_tag_url']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["network_tag_url"]).to eq "https://image.tmdb.org/t/p/original/nm8d7P7MJNiBLdgIzUK0gkuEA4r.png"
    end

    it "should properly assign show creator to show['created_by']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["created_by"]).to eq "Chuck Lorre"
    end

    it "should properly assign show number of seasons to show['number_of_seasons']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["number_of_seasons"].to_i).to be >= 12
    end

    it "should properly assign show number of episodes to show['number_of_episodes']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["number_of_episodes"].to_i).to be >= 259
    end

    it "should properly assign show genre to show['genres']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["genres"]).to eq "Comedy"
    end

    it "should properly assign show type to show['type']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["type"]).to eq "Scripted"
    end

    it "should properly assign show origin country to show['origin_country']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["origin_country"]).to eq "US"
    end

    it "should properly assign show first air date to show['first_air_date']" do
      get :show, params: { tv_id: 1418 }
      expect(assigns(:show)["first_air_date"]).to eq "09-24-2007"
    end

    it "should properly assign show most recent air date to show['last_air_date']" do
      get :show, params: { tv_id: 1996 }
      expect(assigns(:show)["last_air_date"]).to eq "04-01-1966"
    end

    it "should properly assign show overview to show['overview']" do
      get :show, params: { tv_id: 1996 }
      expect(assigns(:show)["overview"]).to eq "The misadventures of two modern-day Stone Age families, the Flintstones and the Rubbles."
    end

    it "should properly assign show justwatch_url to show['justwatch_url']" do
      get :show, params: { tv_id: 1996 }
      expect(assigns(:show)["justwatch_url"]).to eq "https://www.justwatch.com/us/search?q=The Flintstones"
    end

    it "should assign show poster_path_url to an error image if not available from api" do
      get :show, params: { tv_id: 51692 }
      expect(assigns(:show)["poster_path_url"]).to eq "error_image.png"
    end

    it "should not assign show network_tag_url if array from api is empty" do
      get :show, params: { tv_id: 51692 }
      expect(assigns(:show)["network_tag_url"]).to be_nil
    end

    it "should not assign show created_by if array from api is empty" do
      get :show, params: { tv_id: 51692 }
      expect(assigns(:show)["created_by"]).to be_nil
    end

    it "should not assign show genres if array from api is empty" do
      get :show, params: { tv_id: 51692 }
      expect(assigns(:show)["genres"]).to be_nil
    end

    it "should not assign show origin_country if array from api is empty" do
      get :show, params: { tv_id: 51692 }
      expect(assigns(:show)["origin_country"]).to be_nil
    end

    it "should not assign show first_air_date if key from api is nil" do
      get :show, params: { tv_id: 51692 }
      expect(assigns(:show)["first_air_date"]).to be_nil
    end

    it "should not assign show last_air_date if key from api is nil" do
      get :show, params: { tv_id: 51692 }
      expect(assigns(:show)["last_air_date"]).to be_nil
    end

    it "allow assign show overview if key from api is an empty string" do
      get :show, params: { tv_id: 51692 }
      expect(assigns(:show)["overview"]).to eq ""
    end

  end

  describe "GET #search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end

    it "renders the search template" do
      get :search, params: { query: 'Fraggle'}
      expect(response).to render_template :search
    end

    it "renders the search template even with blank input" do
      get :search, params: { query: ''}
      expect(response).to render_template :search
    end

    it "first result when you search for 'Big Bang' is 'The Big Bang Theory'" do
      get :search, params: { query: 'Big Bang'}
      expect(assigns(:shows)[0]["name"]).to eq "The Big Bang Theory"
    end

    it "properly assigns image to search result" do
      get :search, params: { query: 'Big Bang'}
      expect(assigns(:shows)[0]["backdrop_path"]).to eq "/nGsNruW3W27V6r4gkyc3iiEGsKR.jpg"
    end
  end

  describe "fix_date method" do
    it "formats a date from API properly from YYYY-MM-DD to MM-DD-YYYY" do
      response = HTTParty.get("https://api.themoviedb.org/3/tv/1418?api_key=#{ENV["SECRET_API_KEY"]}")
      date = response["first_air_date"]
      expect(controller.fix_date(date)).to eq '09-24-2007'
    end
  end

end
