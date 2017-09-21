require 'rails_helper'

RSpec.describe Task, type: :model do
  fixtures :projects, :tasks

  describe "validation" do
    it "prohibits lat/lon off the map" do
      t = Task.new lat: 9001.0, lon: 9001.0
      aggregate_failures do
        expect(t).to_not be_valid
        expect(t.errors.details[:lat]).to include(error: :less_than, value: 9001.0, count: 90.0)
        expect(t.errors.details[:lon]).to include(error: :less_than, value: 9001.0, count: 180.0)
      end
    end

    it "prohibits located tasks off the project" do
      park = projects(:park_cleanup)

      t = park.tasks.new lat: 39.847346, lon: -104.675133

      aggregate_failures do
        expect(t).to_not be_valid
        expect(t.errors.details[:base]).to include(error: :outside_project)
      end
    end
  end

  it "#has_location? correctly identifies location logic" do
    t = Task.new
    expect(t).to_not have_location
    t.lat = 0.0
    t.lon = 0.0
    expect(t).to have_location
  end
end
