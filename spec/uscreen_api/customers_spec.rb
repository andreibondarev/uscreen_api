# frozen_string_literal: true

RSpec.describe UscreenAPI::Customers do
  let(:client) { UscreenAPI::Client.new(api_key: "123") }
  subject { described_class.new(client: client) }

  describe "#create" do
    let(:response) { JSON.parse(File.read("spec/fixtures/customers_create.json")) }

    before do
      allow(client).to receive(:connection).and_return(Faraday.new do |f|
        f.adapter(:test, Faraday::Adapter::Test::Stubs.new) do |stub|
          stub.post("/customers") { [200, {}, response] }
        end
      end)
    end

    it "returns a list of customers" do
      expect(
        subject.create(
          name: response["name"],
          email: response["email"],
          password: "password"
        )
      ).to eq(response)
    end
  end

  describe "#list" do
    let(:response) { JSON.parse(File.read("spec/fixtures/customers_list.json")) }

    before do
      allow(client).to receive(:connection).and_return(Faraday.new do |f|
        f.adapter(:test, Faraday::Adapter::Test::Stubs.new) do |stub|
          stub.get("/customers") { [200, {}, response] }
        end
      end)
    end

    it "returns a list of customers" do
      expect(subject.list).to eq(response)
    end
  end

  describe "#get" do
    let(:response) { JSON.parse(File.read("spec/fixtures/customers_get.json")) }

    context "by id" do
      let(:id) { 123 }

      before do
        allow(client).to receive(:connection).and_return(Faraday.new do |f|
          f.adapter(:test, Faraday::Adapter::Test::Stubs.new) do |stub|
            stub.get("/customers/123") { [200, {}, response] }
          end
        end)
      end

      it "returns a customer" do
        expect(subject.get(id: id)).to eq(response)
      end
    end

    context "by email" do
      let(:id) { "joe.shmoe@gmail.com" }

      before do
        allow(client).to receive(:connection).and_return(Faraday.new do |f|
          f.adapter(:test, Faraday::Adapter::Test::Stubs.new) do |stub|
            stub.get("/customers/joe.shmoe@gmail.com") { [200, {}, response] }
          end
        end)
      end

      it "returns a customer" do
        expect(subject.get(id: id)).to eq(response)
      end
    end
  end

  describe "#update" do
    let(:response) { JSON.parse(File.read("spec/fixtures/customers_update.json")) }

    let(:id) { 123 }

    before do
      allow(client).to receive(:connection).and_return(Faraday.new do |f|
        f.adapter(:test, Faraday::Adapter::Test::Stubs.new) do |stub|
          stub.put("/customers/#{id}") { [200, {}, response] }
        end
      end)
    end

    context "with name" do
      let(:name) { "John Smith" }

      it "returns a customer" do
        expect(
          subject.update(
            id: id,
            name: name
          )
        ).to eq(response)
        expect(response.dig("name")).to eq(name)
      end
    end

    context "with email" do
      let(:email) { "john.smith@gmail.com" }

      it "returns a customer" do
        expect(
          subject.update(
            id: id,
            email: email
          )
        ).to eq(response)
        expect(response.dig("email")).to eq(email)
      end
    end
  end

  describe "#tokenized_url" do
    let(:response) { JSON.parse(File.read("spec/fixtures/customers_tokenized_url.json")) }

    let(:id) { 123 }

    before do
      allow(client).to receive(:connection).and_return(Faraday.new do |f|
        f.adapter(:test, Faraday::Adapter::Test::Stubs.new) do |stub|
          stub.post("/customers/#{id}/tokenized_url") { [200, {}, response] }
        end
      end)
    end

    it "returns a tokenized url" do
      expect(subject.tokenized_url(id: id)).to eq(response)
    end
  end

  describe "#accesses" do
    let(:response) { JSON.parse(File.read("spec/fixtures/customers_accesses.json")) }

    let(:id) { 123 }

    before do
      allow(client).to receive(:connection).and_return(Faraday.new do |f|
        f.adapter(:test, Faraday::Adapter::Test::Stubs.new) do |stub|
          stub.get("/customers/#{id}/accesses") { [200, {}, response] }
        end
      end)
    end

    it "returns a list of accesses" do
      expect(subject.accesses(id: id)).to eq(response)
    end
  end

  describe "#grant_access" do
    let(:response) { JSON.parse(File.read("spec/fixtures/customers_grant_access.json")) }

    let(:id) { 123 }
    let(:product_id) { 999 }
    let(:product_type) { "recurring" }

    before do
      allow(client).to receive(:connection).and_return(Faraday.new do |f|
        f.adapter(:test, Faraday::Adapter::Test::Stubs.new) do |stub|
          stub.post("/customers/#{id}/accesses") { [200, {}, response] }
        end
      end)
    end

    it "returns a list of accesses" do
      expect(
        subject.grant_access(id: id, product_id: product_id, product_type: product_type)
      ).to eq(response)
    end
  end

  describe "#revoke_access" do
    let(:response) { "success" }

    let(:id) { 123 }
    let(:access_id) { 123 }

    before do
      allow(client).to receive(:connection).and_return(Faraday.new do |f|
        f.adapter(:test, Faraday::Adapter::Test::Stubs.new) do |stub|
          stub.delete("/customers/#{id}/accesses/#{access_id}") { [200, {}, response] }
        end
      end)
    end

    it "returns a list of accesses" do
      expect(subject.revoke_access(id: id, access_id: access_id)).to eq(response)
    end
  end
end
