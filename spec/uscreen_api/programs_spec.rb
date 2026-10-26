# frozen_string_literal: true

RSpec.describe UscreenAPI::Programs do
  subject { client.programs }

  describe "#list" do
    it "returns a list of programs" do
      stub_api(:get, "programs", body: fixture("contents_list")) do |env|
        expect(env.params).to eq("content_type" => "video")
      end

      expect(subject.list(content_type: "video")).to eq(JSON.parse(fixture("contents_list")))
    end
  end

  describe "#get" do
    it "returns a program" do
      stub_api(:get, "programs/1", body: fixture("contents_get"))

      expect(subject.get(id: 1)).to eq(JSON.parse(fixture("contents_get")))
    end
  end

  describe "#chapters" do
    it "returns a list of chapters" do
      stub_api(:get, "programs/1/chapters", body: fixture("contents_playlist_items"))

      expect(subject.chapters(id: 1)).to eq(JSON.parse(fixture("contents_playlist_items")))
    end
  end

  describe "#chapter" do
    it "returns a chapter" do
      stub_api(:get, "programs/1/chapters/2", body: fixture("contents_playlist_item"))

      expect(subject.chapter(id: 1, chapter_id: 2)).to eq(JSON.parse(fixture("contents_playlist_item")))
    end
  end
end
