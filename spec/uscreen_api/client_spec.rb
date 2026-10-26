# frozen_string_literal: true

RSpec.describe UscreenAPI::Client do
  it "has a version number" do
    expect(UscreenAPI::VERSION).not_to be nil
  end

  it "sends the API key in the Authorization header" do
    stub_api(:get, "customers", body: "[]") do |env|
      expect(env.request_headers["Authorization"]).to eq("123")
    end

    client.customers.list
  end

  {
    analytics: UscreenAPI::Analytics,
    contents: UscreenAPI::Contents,
    customers: UscreenAPI::Customers,
    email_topics: UscreenAPI::EmailTopics,
    groups: UscreenAPI::Groups,
    invoices: UscreenAPI::Invoices,
    offers: UscreenAPI::Offers,
    programs: UscreenAPI::Programs,
    videos: UscreenAPI::Videos
  }.each do |method, klass|
    it "exposes ##{method}" do
      expect(client.public_send(method)).to be_a(klass)
    end
  end

  describe "error handling" do
    {
      401 => UscreenAPI::Errors::Unauthorized,
      404 => UscreenAPI::Errors::NotFound,
      422 => UscreenAPI::Errors::UnprocessableEntity,
      500 => UscreenAPI::Errors::Error
    }.each do |status, error|
      it "raises #{error} on #{status}" do
        stub_api(:get, "offers/1", status: status, body: '{"error":"message"}')

        expect { client.offers.get(id: 1) }.to raise_error(error)
      end
    end

    it "raises customer specific errors that remain rescuable as generic errors" do
      stub_api(:get, "customers/1", status: 404, body: '{"error":"Not found"}')

      expect { client.customers.get(id: 1) }.to raise_error(UscreenAPI::Errors::UserNotFound)
      expect(UscreenAPI::Errors::UserNotFound).to be < UscreenAPI::Errors::NotFound
      expect(UscreenAPI::Errors::UserNotCreated).to be < UscreenAPI::Errors::UnprocessableEntity
    end
  end
end
