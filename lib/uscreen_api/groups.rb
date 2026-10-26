# frozen_string_literal: true

module UscreenAPI
  class Groups < Base
    PATH = "groups"

    # Get paginated list of groups
    # @param page [Integer] Page number
    # @param from [String] Starting date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param date_field [String] Date field to filter by. Available fields: created_at, updated_at. Default: created_at.
    def list(page: nil, from: nil, to: nil, date_field: nil)
      request(:get, PATH, params: {page: page, from: from, to: to, date_field: date_field})
    end

    # Create a new group
    # @param name [String] Group name
    # @param billing_email [String] Billing email for the group
    # @param plan_id [Integer] Subscription Plan ID associated with the group
    # @param number_of_seats [Integer] Number of seats in the group. No seat limit if not provided.
    def create(name:, billing_email:, plan_id:, number_of_seats: nil)
      request(:post, PATH, body: {
        name: name,
        billing_email: billing_email,
        plan_id: plan_id,
        number_of_seats: number_of_seats
      })
    end

    # Delete a group
    # @param id [Integer] Group ID
    def delete(id:)
      request(:delete, "#{PATH}/#{id}")
    end

    # Get paginated list of group members
    # @param id [Integer] Group ID
    # @param page [Integer] Page number
    # @param from [String] Starting date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param date_field [String] Date field to filter by. Available fields: created_at, updated_at. Default: created_at.
    def members(id:, page: nil, from: nil, to: nil, date_field: nil)
      request(:get, "#{PATH}/#{id}/members", params: {page: page, from: from, to: to, date_field: date_field})
    end

    # Add a member to a group
    # @param id [Integer] Group ID
    # @param email [String] Member's email address
    # @param name [String] Member's full name
    # @param role [String] Member's role in the group. Can be member|manager
    # @param skip_automations [Boolean] Skip automation enrollment (e.g. lead_created). Default false.
    def add_member(id:, email:, name:, role: "member", skip_automations: nil)
      request(:post, "#{PATH}/#{id}/members", body: {
        email: email,
        name: name,
        role: role,
        skip_automations: skip_automations
      })
    end

    # Remove a member from a group
    # @param id [Integer] Group ID
    # @param user_id [Integer] User ID
    def remove_member(id:, user_id:)
      request(:delete, "#{PATH}/#{id}/members/#{user_id}")
    end
  end
end
