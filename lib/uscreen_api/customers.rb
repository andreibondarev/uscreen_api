# frozen_string_literal: true

module UscreenAPI
  class Customers < Base
    PATH = "customers"

    # Get paginated list of customers
    # @param page [Integer] Page number
    # @param from [String] Starting date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param date_field [String] Date field to filter by. Available fields: created_at, updated_at. Default: created_at. If not set, created_at is used.
    def list(
      page: nil,
      from: nil,
      to: nil,
      date_field: nil
    )
      response = client.connection.get(PATH) do |req|
        req.params = {}

        req.params["page"] = page if page
        req.params["from"] = from if from
        req.params["to"] = to if to
        req.params["date_field"] = date_field if date_field
      end

      handle_errors(response.status, response.body)

      response.body
    end

    # Invite a new customer
    # @param email [String] Customer email
    # @param name [String] Customer name
    # @param password [String] Customer password
    # @param payment_user_id [String] Payment user ID
    # @param skip_invite [Boolean] Skip invite email
    # @param opted_in_for_news_and_updates [Boolean] Opted in for news and updates
    # @param custom_fields [Hash] Custom fields
    def create(
      email:,
      name:,
      password: nil,
      payment_user_id: nil,
      skip_invite: nil,
      opted_in_for_news_and_updates: nil,
      custom_fields: {}
    )
      response = client.connection.post(PATH) do |req|
        req.body = {
          email: email,
          name: name
        }
        req.body["password"] = password if password
        req.body["payment_user_id"] = payment_user_id if payment_user_id
        req.body["skip_invite"] = skip_invite if skip_invite
        req.body["opted_in_for_news_and_updates"] = opted_in_for_news_and_updates if opted_in_for_news_and_updates

        custom_fields.each { |key, value| req.body[key] = value } if custom_fields.any?
      end

      handle_errors(response.status, response.body)

      response.body
    end

    # Get a customer information
    # @param id [Integer] Customer ID or Email
    def get(id:)
      response = client.connection.get("#{PATH}/#{id}")

      handle_errors(response.status, response.body)

      response.body
    end

    # Update a customer information
    # @param id [Integer] Customer ID or Email
    # @param email [String] New customer email
    # @param name [String] New customer name
    # @param password [String] New customer password
    # @param custom_fields [Hash] Custom fields
    def update(
      id:,
      email: nil,
      name: nil,
      password: nil,
      custom_fields: {}
    )
      response = client.connection.put("#{PATH}/#{id}") do |req|
        req.body = {}

        req.body["email"] = email if email
        req.body["name"] = name if name
        req.body["password"] = password if password

        custom_fields.each { |key, value| req.body[key] = value } if custom_fields.any?
      end

      handle_errors(response.status, response.body)

      response.body
    end

    # Generates a Single Sign-On link for a customer
    # @param id [Integer] Customer ID or Email
    def tokenized_url(id:)
      response = client.connection.post("#{PATH}/#{id}/tokenized_url")
      handle_errors(response.status, response.body)

      response.body
    end

    # Get paginated list of accesses for a customer
    # @param id [Integer] Customer ID or Email
    # @param page [Integer] Page number
    # @param from [String] Starting date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    def accesses(
      id:,
      page: nil,
      from: nil,
      to: nil
    )
      response = client.connection.get("#{PATH}/#{id}/accesses")
      handle_errors(response.status, response.body)

      response.body
    end

    # Grant access to a customer
    # @param id [Integer] Customer ID or Email
    # @param product_id [Integer] Product ID
    # @param product_type [String] Uscreen system product type. Can be a program|recurring|rent|freebie|fixed_price
    # @param perform_action_at [String] Seconds since the Epoch. Next perform action needed in case of rent or recurring product types. System will add next due automatically in case of a blank field. example: 2024-07-05T13:47:52Z
    # @param with_manual_billing [Boolean] Allows you to process billing outside the Uscreen platform. Default false.
    def grant_access(
      id:,
      product_id:,
      product_type:,
      perform_action_at: nil,
      with_manual_billing: false
    )
      response = client.connection.post("#{PATH}/#{id}/accesses") do |req|
        req.body = {
          product_id: product_id,
          product_type: product_type,
          with_manual_billing: with_manual_billing
        }
        req.body["perform_action_at"] = perform_action_at if perform_action_at
      end

      handle_errors(response.status, response.body)

      response.body
    end

    # Revoke access by ID
    # @param id [Integer] Customer ID or Email
    # @param access_id [Integer] Access ID
    def revoke_access(
      id:,
      access_id:
    )
      response = client.connection.delete("#{PATH}/#{id}/accesses/#{access_id}")
      handle_errors(response.status, response.body)

      response.body
    end
  end
end
