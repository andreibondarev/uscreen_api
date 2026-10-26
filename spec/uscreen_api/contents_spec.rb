# frozen_string_literal: true

RSpec.describe UscreenAPI::Contents do
  subject { client.contents }

  let(:content) { JSON.parse(fixture("contents_get")) }

  describe "#list" do
    it "returns a list of contents" do
      stub_api(:get, "contents", body: fixture("contents_list")) do |env|
        expect(env.params).to eq("page" => "2", "include" => "author", "content_type" => "live_event")
      end

      expect(
        subject.list(page: 2, include: "author", content_type: "live_event")
      ).to eq(JSON.parse(fixture("contents_list")))
    end
  end

  describe "#get" do
    it "returns a content" do
      stub_api(:get, "contents/1", body: fixture("contents_get"))

      expect(subject.get(id: 1)).to eq(content)
    end
  end

  describe "#playlist_items" do
    it "returns a list of playlist items" do
      stub_api(:get, "contents/1/playlist_items", body: fixture("contents_playlist_items"))

      expect(subject.playlist_items(id: 1)).to eq(JSON.parse(fixture("contents_playlist_items")))
    end
  end

  describe "#playlist_item" do
    it "returns a playlist item" do
      stub_api(:get, "contents/1/playlist_items/2", body: fixture("contents_playlist_item"))

      expect(subject.playlist_item(id: 1, playlist_item_id: 2)).to eq(JSON.parse(fixture("contents_playlist_item")))
    end
  end

  describe "#publish" do
    it "publishes the content" do
      stub_api(:post, "contents/1/visibility/publish", body: fixture("contents_get")) do |env|
        expect(env.params).to eq("event_launch_datetime" => "2025-06-01T12:00:00Z")
      end

      expect(subject.publish(id: 1, event_launch_datetime: "2025-06-01T12:00:00Z")).to eq(content)
    end
  end

  describe "#unpublish" do
    it "unpublishes the content" do
      stub_api(:post, "contents/1/visibility/unpublish", body: fixture("contents_get"))

      expect(subject.unpublish(id: 1)).to eq(content)
    end
  end

  describe "#schedule" do
    it "schedules the content" do
      stub_api(:post, "contents/1/visibility/schedule", body: fixture("contents_get")) do |env|
        expect(env.params).to eq("scheduled_datetime" => "2025-06-01T12:00:00Z", "schedule_published" => "true")
      end

      expect(
        subject.schedule(id: 1, scheduled_datetime: "2025-06-01T12:00:00Z", schedule_published: true)
      ).to eq(content)
    end
  end
end
