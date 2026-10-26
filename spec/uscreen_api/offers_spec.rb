# frozen_string_literal: true

RSpec.describe UscreenAPI::Offers do
  subject { client.offers }

  describe "#list" do
    it "returns a list of offers" do
      stub_api(:get, "offers", body: fixture("offers_list")) do |env|
        expect(env.params).to eq("page" => "2")
      end

      expect(subject.list(page: 2)).to eq(JSON.parse(fixture("offers_list")))
    end
  end

  describe "#get" do
    it "returns an offer" do
      stub_api(:get, "offers/1", body: fixture("offers_get"))

      expect(subject.get(id: 1)).to eq(JSON.parse(fixture("offers_get")))
    end
  end
end
