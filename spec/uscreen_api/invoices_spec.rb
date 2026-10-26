# frozen_string_literal: true

RSpec.describe UscreenAPI::Invoices do
  subject { client.invoices }

  describe "#list" do
    it "returns a list of invoices" do
      stub_api(:get, "invoices", body: fixture("invoices_list")) do |env|
        expect(env.params).to eq("page" => "2", "from" => "2023-01-01T00:00:00Z", "to" => "2023-02-01T00:00:00Z", "date_field" => "created_at")
      end

      expect(
        subject.list(page: 2, from: "2023-01-01T00:00:00Z", to: "2023-02-01T00:00:00Z", date_field: "created_at")
      ).to eq(JSON.parse(fixture("invoices_list")))
    end
  end

  describe "#get" do
    it "returns an invoice" do
      stub_api(:get, "invoices/1", body: fixture("invoices_get"))

      expect(subject.get(id: 1)).to eq(JSON.parse(fixture("invoices_get")))
    end
  end
end
