require 'rails_helper'
require 'capybara/rspec'

RSpec.describe TvshowsController, type: :controller do

  describe "GET #index" do
    it "renders the index template" do
        get :index
        expect(response).to render_template("index")
    end

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
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
  end

end
