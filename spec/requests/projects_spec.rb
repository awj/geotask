require 'rails_helper'

describe "/projects" do
  fixtures :projects

  it "index" do
  end

  describe "show" do
    it "happy path" do
    end

    it "nonexistent projects" do
      get "/projects/asdf"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "create" do
    it "happy path" do
      params = {
        project: {
          name: "Test",
          north: 20.0,
          south: 10.0,
          east: 20.0,
          west: 10.0
        }
      }

      post "/projects", params: params

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include("name" => "Test", "permalink" => "test")
    end

    it "invalid info" do
      params = {
        project: {
          # name: "Test",
          north: 20.0,
          south: 10.0,
          east: 200.0,
          west: 10.0
        }
      }

      post "/projects", params: params

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["name"]).to include("error" => "blank")
    end
  end

  it "update" do
  end

  it "destroy" do
    delete "/projects/park-cleanup"

    expect(Project.lookup("park-cleanup")).to be_nil
  end
end
