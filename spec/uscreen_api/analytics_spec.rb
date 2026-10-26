# frozen_string_literal: true

RSpec.describe UscreenAPI::Analytics do
  subject { client.analytics }

  describe "#video_views" do
    it "returns video views" do
      stub_api(:get, "analytics/videos/views", body: fixture("analytics_video_views")) do |env|
        expect(env.params).to eq(
          "page" => "2",
          "per_page" => "50",
          "user_id" => "joe.shmoe@gmail.com",
          "content_id" => "143",
          "from" => "2025-01-01T00:00:00Z",
          "to" => "2025-02-01T00:00:00Z"
        )
      end

      expect(
        subject.video_views(
          page: 2,
          per_page: 50,
          user_id: "joe.shmoe@gmail.com",
          content_id: 143,
          from: "2025-01-01T00:00:00Z",
          to: "2025-02-01T00:00:00Z"
        )
      ).to eq(JSON.parse(fixture("analytics_video_views")))
    end
  end

  describe "#total_watch_time" do
    it "returns the total watch time" do
      stub_api(:get, "analytics/videos/views/total_watch_time", body: fixture("analytics_total_watch_time")) do |env|
        expect(env.params).to eq("user_id" => "123")
      end

      expect(subject.total_watch_time(user_id: 123)).to eq(JSON.parse(fixture("analytics_total_watch_time")))
    end
  end

  describe "#video_views_summary" do
    it "returns the video views summary" do
      stub_api(:get, "analytics/videos/views/summary", body: fixture("analytics_video_views_summary")) do |env|
        expect(env.params).to eq("page" => "1", "per_page" => "100")
      end

      expect(
        subject.video_views_summary(page: 1, per_page: 100)
      ).to eq(JSON.parse(fixture("analytics_video_views_summary")))
    end
  end
end
