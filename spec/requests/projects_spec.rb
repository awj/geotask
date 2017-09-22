require 'rails_helper'

describe "/projects" do
  fixtures :projects

  describe "index" do
    it "for html" do
    end

    it "for json" do
      get "/projects", headers: { accept: "application/json" }

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(response).to have_content_type("application/json")
        json = JSON.parse(response.body)

        meta = json["meta"]
        projects = json["projects"]
        expect(meta).to include("current_page" => 1, "total_pages" => 1, "total_count" => 1)
        expect(projects[0]).to include("name" => "Park cleanup")
      end
    end
  end

  describe "show" do
    it "happy path" do
      get "/projects/park-cleanup"

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)["project"]
        expect(json).to include("name" => "Park cleanup")
      end
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
      expect(JSON.parse(response.body)["project"]).to include("name" => "Test", "permalink" => "test")
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
    id = projects(:park_cleanup).id

    new_description = "Graffiti removal and minor repairs."

    put "/projects/park-cleanup", params: { project: { description: new_description } }

    aggregate_failures do
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)["project"]
      expect(json["description"]).to eq(new_description)

      expect(Project.find(id).description).to eq(new_description)
    end
  end

  it "destroy" do
    delete "/projects/park-cleanup"

    expect(Project.lookup("park-cleanup")).to be_nil
  end
end
