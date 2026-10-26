# frozen_string_literal: true

RSpec.describe UscreenAPI::Customers do
  subject { client.customers }

  describe "#list" do
    let(:response) { JSON.parse(fixture("customers_list")) }

    it "returns a list of customers" do
      stub_api(:get, "customers", body: fixture("customers_list"))

      expect(subject.list).to eq(response)
    end

    it "sends filters as query params" do
      stub_api(:get, "customers", body: fixture("customers_list")) do |env|
        expect(env.params).to eq(
          "page" => "2",
          "from" => "2023-01-01T00:00:00Z",
          "to" => "2023-02-01T00:00:00Z",
          "date_field" => "updated_at"
        )
      end

      subject.list(page: 2, from: "2023-01-01T00:00:00Z", to: "2023-02-01T00:00:00Z", date_field: "updated_at")
    end
  end

  describe "#create" do
    let(:response) { JSON.parse(fixture("customers_create")) }

    it "returns the created customer" do
      stub_api(:post, "customers", body: fixture("customers_create")) do |env|
        expect(request_body(env)).to eq(
          "email" => response["email"],
          "name" => response["name"],
          "password" => "password"
        )
      end

      expect(
        subject.create(name: response["name"], email: response["email"], password: "password")
      ).to eq(response)
    end

    it "sends optional params, including false values, and custom fields" do
      stub_api(:post, "customers", body: fixture("customers_create")) do |env|
        expect(request_body(env)).to eq(
          "email" => "joe.shmoe@gmail.com",
          "name" => "Joe Shmoe",
          "skip_invite" => true,
          "opted_in_for_news_and_updates" => false,
          "opted_in_for_community_updates" => false,
          "legacy_id" => "ext-1",
          "tags" => ["vip"],
          "unsubscribed_topic_ids" => [1],
          "field_1" => "value"
        )
      end

      subject.create(
        name: "Joe Shmoe",
        email: "joe.shmoe@gmail.com",
        skip_invite: true,
        opted_in_for_news_and_updates: false,
        opted_in_for_community_updates: false,
        legacy_id: "ext-1",
        tags: ["vip"],
        unsubscribed_topic_ids: [1],
        custom_fields: {field_1: "value"}
      )
    end

    it "raises UserNotCreated on validation errors" do
      stub_api(:post, "customers", status: 422, body: '{"error":"Email has already been taken"}')

      expect {
        subject.create(name: "Joe Shmoe", email: "joe.shmoe@gmail.com")
      }.to raise_error(UscreenAPI::Errors::UserNotCreated)
    end
  end

  describe "#get" do
    let(:response) { JSON.parse(fixture("customers_get")) }

    it "returns a customer by id" do
      stub_api(:get, "customers/123", body: fixture("customers_get"))

      expect(subject.get(id: 123)).to eq(response)
    end

    it "returns a customer by email" do
      stub_api(:get, "customers/joe.shmoe@gmail.com", body: fixture("customers_get"))

      expect(subject.get(id: "joe.shmoe@gmail.com")).to eq(response)
    end

    it "raises UserNotFound when the customer does not exist" do
      stub_api(:get, "customers/999", status: 404, body: '{"error":"Not found"}')

      expect { subject.get(id: 999) }.to raise_error(UscreenAPI::Errors::UserNotFound)
    end
  end

  describe "#update" do
    let(:response) { JSON.parse(fixture("customers_update")) }

    it "sends only the given attributes" do
      stub_api(:put, "customers/123", body: fixture("customers_update")) do |env|
        expect(request_body(env)).to eq("name" => "John Smith", "email" => "john.smith@gmail.com")
      end

      expect(
        subject.update(id: 123, name: "John Smith", email: "john.smith@gmail.com")
      ).to eq(response)
    end

    it "sends optional params and custom fields" do
      stub_api(:put, "customers/123", body: fixture("customers_update")) do |env|
        expect(request_body(env)).to eq(
          "payment_user_id" => "cus_123",
          "opted_in_for_news_and_updates" => false,
          "opted_in_for_community_updates" => true,
          "tags" => ["annual-member"],
          "unsubscribed_topic_ids" => [2],
          "field_2" => "value"
        )
      end

      subject.update(
        id: 123,
        payment_user_id: "cus_123",
        opted_in_for_news_and_updates: false,
        opted_in_for_community_updates: true,
        tags: ["annual-member"],
        unsubscribed_topic_ids: [2],
        custom_fields: {field_2: "value"}
      )
    end
  end

  describe "#tokenized_url" do
    it "returns a tokenized url" do
      stub_api(:post, "customers/123/tokenized_url", body: fixture("customers_tokenized_url"))

      expect(subject.tokenized_url(id: 123)).to eq(JSON.parse(fixture("customers_tokenized_url")))
    end
  end

  describe "#accesses" do
    let(:response) { JSON.parse(fixture("customers_accesses")) }

    it "returns a list of accesses" do
      stub_api(:get, "customers/123/accesses", body: fixture("customers_accesses"))

      expect(subject.accesses(id: 123)).to eq(response)
    end

    it "sends filters as query params" do
      stub_api(:get, "customers/123/accesses", body: fixture("customers_accesses")) do |env|
        expect(env.params).to eq("page" => "2", "from" => "2023-01-01T00:00:00Z", "to" => "2023-02-01T00:00:00Z")
      end

      subject.accesses(id: 123, page: 2, from: "2023-01-01T00:00:00Z", to: "2023-02-01T00:00:00Z")
    end
  end

  describe "#access" do
    it "returns an access" do
      stub_api(:get, "customers/123/accesses/456", body: fixture("customers_grant_access"))

      expect(subject.access(id: 123, access_id: 456)).to eq(JSON.parse(fixture("customers_grant_access")))
    end
  end

  describe "#grant_access" do
    let(:response) { JSON.parse(fixture("customers_grant_access")) }

    it "returns the granted access" do
      stub_api(:post, "customers/123/accesses", body: fixture("customers_grant_access")) do |env|
        expect(request_body(env)).to eq(
          "product_id" => 999,
          "product_type" => "recurring",
          "with_manual_billing" => false
        )
      end

      expect(
        subject.grant_access(id: 123, product_id: 999, product_type: "recurring")
      ).to eq(response)
    end

    it "sends optional params" do
      stub_api(:post, "customers/123/accesses", body: fixture("customers_grant_access")) do |env|
        expect(request_body(env)).to eq(
          "product_id" => 999,
          "product_type" => "rent",
          "perform_action_at" => "2024-07-05T13:47:52Z",
          "with_manual_billing" => false,
          "skip_automations" => true
        )
      end

      subject.grant_access(
        id: 123,
        product_id: 999,
        product_type: "rent",
        perform_action_at: "2024-07-05T13:47:52Z",
        skip_automations: true
      )
    end
  end

  describe "#revoke_access" do
    it "revokes the access" do
      stub_api(:delete, "customers/123/accesses/456", body: '"success"')

      expect(subject.revoke_access(id: 123, access_id: 456)).to eq("success")
    end
  end

  describe "#subscription" do
    let(:response) { JSON.parse(fixture("customers_subscription")) }

    it "returns the active subscription" do
      stub_api(:get, "customers/123/subscription", body: fixture("customers_subscription"))

      expect(subject.subscription(id: 123)).to eq(response)
    end

    it "returns nil when there is no active subscription" do
      stub_api(:get, "customers/123/subscription", status: 204)

      expect(subject.subscription(id: 123)).to be_nil
    end
  end

  describe "#create_subscription" do
    it "returns the created subscription" do
      stub_api(:post, "customers/123/subscription", body: fixture("customers_subscription")) do |env|
        expect(request_body(env)).to eq(
          "product_id" => 456,
          "perform_action_at" => 1720187272,
          "currency" => "USD",
          "cover_fees" => false,
          "skip_automations" => true
        )
      end

      expect(
        subject.create_subscription(
          id: 123,
          product_id: 456,
          perform_action_at: 1720187272,
          currency: "USD",
          cover_fees: false,
          skip_automations: true
        )
      ).to eq(JSON.parse(fixture("customers_subscription")))
    end
  end

  describe "#cancel_subscription" do
    it "returns the canceled subscription" do
      stub_api(:delete, "customers/123/subscription", body: fixture("customers_subscription"))

      expect(subject.cancel_subscription(id: 123)).to eq(JSON.parse(fixture("customers_subscription")))
    end
  end
end
