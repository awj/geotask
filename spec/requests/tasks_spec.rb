require 'rails_helper'

describe "/projects/:id/tasks" do
  fixtures :projects, :tasks

  let(:headers) do
    { accept: "application/json" }
  end

  it "index" do
    get "/projects/park-cleanup/tasks", headers: headers

    aggregate_failures do
      expect(response).to have_http_status(:ok)
      expect(response).to have_content_type("application/json")
      json = JSON.parse(response.body)

      meta = json["meta"]
      tasks = json["tasks"]
      expect(meta).to include("current_page" => 1, "total_pages" => 1, "total_count" => 3)
      expect(tasks).to include(a_hash_including("name" => "Remove graffiti"))
    end
  end

  describe "show" do
    it "happy path" do
      id = tasks(:remove_graffiti).id
      get "/projects/park-cleanup/tasks/#{id}"

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)["task"]
        expect(json).to include("name" => "Remove graffiti")
      end
    end

    it "nonexistent task" do
      get "/projects/park-cleanup/tasks/42"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "create" do
    it "happy path" do
      params = {
        task: {
          name: "Pick up litter"
        }
      }

      post "/projects/park-cleanup/tasks", params: params, headers: headers

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)["task"]).to include("name" => "Pick up litter")
    end

    it "invalid info" do
      params = {
        task: {
          # name: "Test",
          lat: 20.0,
          lon: 10.0
        }
      }

      post "/projects/park-cleanup/tasks", params: params, headers: headers

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["base"]).to include("error" => "outside_project")
    end
  end

  it "update" do
    id = tasks(:replace_lights).id

    new_name = "Fix benches"

    put "/projects/park-cleanup/tasks/#{id}",
        params: { task: { name: new_name } },
        headers: headers

    aggregate_failures do
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)["task"]
      expect(json["name"]).to eq(new_name)

      expect(Task.find(id).name).to eq(new_name)
    end
  end

  it "destroy" do
    id = tasks(:mow_grass).id
    delete "/projects/park-cleanup/tasks/#{id}"

    expect(Task.find_by(id: id)).to be_nil
  end
end
