# frozen_string_literal: true

RSpec.describe UscreenAPI::Groups do
  subject { client.groups }

  describe "#list" do
    it "returns a list of groups" do
      stub_api(:get, "groups", body: fixture("groups_list")) do |env|
        expect(env.params).to eq("page" => "2", "date_field" => "updated_at")
      end

      expect(subject.list(page: 2, date_field: "updated_at")).to eq(JSON.parse(fixture("groups_list")))
    end
  end

  describe "#create" do
    it "returns the created group" do
      stub_api(:post, "groups", status: 201, body: fixture("groups_create")) do |env|
        expect(request_body(env)).to eq(
          "name" => "Acme",
          "billing_email" => "billing@acme.com",
          "plan_id" => 1,
          "number_of_seats" => 10
        )
      end

      expect(
        subject.create(name: "Acme", billing_email: "billing@acme.com", plan_id: 1, number_of_seats: 10)
      ).to eq(JSON.parse(fixture("groups_create")))
    end
  end

  describe "#delete" do
    it "deletes the group" do
      stub_api(:delete, "groups/1")

      subject.delete(id: 1)
    end
  end

  describe "#members" do
    it "returns a list of group members" do
      stub_api(:get, "groups/1/members", body: fixture("groups_members")) do |env|
        expect(env.params).to eq("page" => "2")
      end

      expect(subject.members(id: 1, page: 2)).to eq(JSON.parse(fixture("groups_members")))
    end
  end

  describe "#add_member" do
    it "returns the added member" do
      stub_api(:post, "groups/1/members", status: 201, body: fixture("groups_add_member")) do |env|
        expect(request_body(env)).to eq(
          "email" => "jane@acme.com",
          "name" => "Jane Doe",
          "role" => "manager",
          "skip_automations" => true
        )
      end

      expect(
        subject.add_member(id: 1, email: "jane@acme.com", name: "Jane Doe", role: "manager", skip_automations: true)
      ).to eq(JSON.parse(fixture("groups_add_member")))
    end

    it "defaults the role to member" do
      stub_api(:post, "groups/1/members", status: 201, body: fixture("groups_add_member")) do |env|
        expect(request_body(env)).to eq("email" => "jane@acme.com", "name" => "Jane Doe", "role" => "member")
      end

      subject.add_member(id: 1, email: "jane@acme.com", name: "Jane Doe")
    end
  end

  describe "#remove_member" do
    it "removes the member" do
      stub_api(:delete, "groups/1/members/2")

      subject.remove_member(id: 1, user_id: 2)
    end
  end
end
