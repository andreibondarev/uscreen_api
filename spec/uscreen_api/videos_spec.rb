# frozen_string_literal: true

RSpec.describe UscreenAPI::Videos do
  subject { client.videos }

  describe "#list" do
    it "returns a list of videos" do
      stub_api(:get, "videos", body: fixture("videos_list")) do |env|
        expect(env.params).to eq("page" => "2", "include" => "author")
      end

      expect(subject.list(page: 2, include: "author")).to eq(JSON.parse(fixture("videos_list")))
    end
  end

  describe "#get" do
    it "returns a video" do
      stub_api(:get, "videos/1", body: fixture("videos_get")) do |env|
        expect(env.params).to eq("include" => "author")
      end

      expect(subject.get(id: 1, include: "author")).to eq(JSON.parse(fixture("videos_get")))
    end
  end
end
