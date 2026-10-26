# frozen_string_literal: true

RSpec.describe UscreenAPI::EmailTopics do
  subject { client.email_topics }

  describe "#list" do
    it "returns a list of email topics" do
      stub_api(:get, "email_topics", body: fixture("email_topics_list")) do |env|
        expect(env.params).to eq("page" => "2")
      end

      expect(subject.list(page: 2)).to eq(JSON.parse(fixture("email_topics_list")))
    end
  end
end
