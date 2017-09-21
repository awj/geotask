require 'rails_helper'

RSpec.describe Project, type: :model do
  fixtures :projects
  
  describe "permalink handling" do
    it "generates a new permalink off the name prior to validation" do
      subject.name = "Do Some Stuff"
      expect(subject.permalink).to be_nil
      subject.valid?
      expect(subject.permalink).to eq("do-some-stuff")
    end

    it "doesn't clobber pre-assigned permalinks" do
      subject.name = "A New Hope"
      subject.permalink = "return-of-the-jedi"
      subject.valid?
      expect(subject.permalink).to eq("return-of-the-jedi")
    end

    it ".lookup works on permalinks" do
      found = Project.lookup "park-cleanup"
      expected = projects(:park_cleanup)

      expect(found).to eq(expected)
    end
  end

  it "uses permalinks to convert to parameters" do
    project = projects(:park_cleanup)

    expect(project.to_param).to eq("park-cleanup")
  end
end
