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
      request(:get, PATH, params: {page: page, from: from, to: to, date_field: date_field})
    end

    # Invite a new customer
    # @param email [String] Customer email. Should be unique
    # @param name [String] Customer name
    # @param password [String] Password (8 characters minimum). Generated automatically if blank.
    # @param payment_user_id [String] Stripe User ID, for matching Stripe accounts
    # @param skip_invite [Boolean] Skip the platform invite email
    # @param opted_in_for_news_and_updates [Boolean] Opted in for news and update emails
    # @param opted_in_for_community_updates [Boolean] Opted in for community update emails
    # @param legacy_id [String] External identifier used to reference this customer in third-party systems
    # @param tags [Array<String>] Tag names to assign to the customer (lowercase letters, numbers and dashes)
    # @param unsubscribed_topic_ids [Array<Integer>] Email topic IDs to unsubscribe the customer from
    # @param custom_fields [Hash] Custom fields. Example: { field_1: "value" }
    def create(
      email:,
      name:,
      password: nil,
      payment_user_id: nil,
      skip_invite: nil,
      opted_in_for_news_and_updates: nil,
      opted_in_for_community_updates: nil,
      legacy_id: nil,
      tags: nil,
      unsubscribed_topic_ids: nil,
      custom_fields: {}
    )
      request(:post, PATH, body: {
        email: email,
        name: name,
        password: password,
        payment_user_id: payment_user_id,
        skip_invite: skip_invite,
        opted_in_for_news_and_updates: opted_in_for_news_and_updates,
        opted_in_for_community_updates: opted_in_for_community_updates,
        legacy_id: legacy_id,
        tags: tags,
        unsubscribed_topic_ids: unsubscribed_topic_ids,
        **custom_fields
      })
    end

    # Get a customer information
    # @param id [Integer] Customer ID or Email
    def get(id:)
      request(:get, "#{PATH}/#{id}")
    end

    # Update a customer information
    # @param id [Integer] Customer ID or Email
    # @param email [String] New customer email
    # @param name [String] New customer name
    # @param password [String] New customer password (8 characters minimum)
    # @param payment_user_id [String] Stripe Customer ID
    # @param opted_in_for_news_and_updates [Boolean] Receive marketing emails
    # @param opted_in_for_community_updates [Boolean] Receive community update emails
    # @param tags [Array<String>] Tag names to assign to the customer. Replaces existing tags.
    # @param unsubscribed_topic_ids [Array<Integer>] Email topic IDs to unsubscribe the customer from
    # @param custom_fields [Hash] Custom fields. Example: { field_1: "value" }
    def update(
      id:,
      email: nil,
      name: nil,
      password: nil,
      payment_user_id: nil,
      opted_in_for_news_and_updates: nil,
      opted_in_for_community_updates: nil,
      tags: nil,
      unsubscribed_topic_ids: nil,
      custom_fields: {}
    )
      request(:put, "#{PATH}/#{id}", body: {
        email: email,
        name: name,
        password: password,
        payment_user_id: payment_user_id,
        opted_in_for_news_and_updates: opted_in_for_news_and_updates,
        opted_in_for_community_updates: opted_in_for_community_updates,
        tags: tags,
        unsubscribed_topic_ids: unsubscribed_topic_ids,
        **custom_fields
      })
    end

    # Generates a Single Sign-On link for a customer
    # @param id [Integer] Customer ID or Email
    def tokenized_url(id:)
      request(:post, "#{PATH}/#{id}/tokenized_url")
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
      request(:get, "#{PATH}/#{id}/accesses", params: {page: page, from: from, to: to})
    end

    # Get access by ID
    # @param id [Integer] Customer ID or Email
    # @param access_id [Integer] Access ID
    def access(id:, access_id:)
      request(:get, "#{PATH}/#{id}/accesses/#{access_id}")
    end

    # Grant access to a customer
    # @param id [Integer] Customer ID or Email
    # @param product_id [Integer] Product ID
    # @param product_type [String] Uscreen system product type. Can be a program|recurring|rent|freebie|fixed_price
    # @param perform_action_at [String] Next perform action needed in case of rent or recurring product types. System will add next due automatically in case of a blank field. Omit when with_manual_billing is true. Example: 2024-07-05T13:47:52Z
    # @param with_manual_billing [Boolean] Allows you to process billing outside the Uscreen platform. Default false.
    # @param skip_automations [Boolean] Skip automation enrollment (e.g. bundle_assigned). Default false.
    def grant_access(
      id:,
      product_id:,
      product_type: nil,
      perform_action_at: nil,
      with_manual_billing: false,
      skip_automations: nil
    )
      request(:post, "#{PATH}/#{id}/accesses", body: {
        product_id: product_id,
        product_type: product_type,
        perform_action_at: perform_action_at,
        with_manual_billing: with_manual_billing,
        skip_automations: skip_automations
      })
    end

    # Revoke access by ID
    # @param id [Integer] Customer ID or Email
    # @param access_id [Integer] Access ID
    def revoke_access(
      id:,
      access_id:
    )
      request(:delete, "#{PATH}/#{id}/accesses/#{access_id}")
    end

    # Get a customer's active subscription. Returns nil if the customer has no active subscription.
    # @param id [Integer] Customer ID or Email
    def subscription(id:)
      request(:get, "#{PATH}/#{id}/subscription")
    end

    # Create a subscription for a customer
    # @param id [Integer] Customer ID or Email
    # @param product_id [Integer] Subscription plan ID
    # @param with_manual_billing [Boolean] Process billing outside the Uscreen platform. Default false.
    # @param perform_action_at [Integer] Unix timestamp for the next billing/renewal date. Omit when with_manual_billing is true.
    # @param currency [String] Three-letter currency code (ISO 4217). Must be one of the store's configured currencies.
    # @param cover_fees [Boolean] Add transaction fees to the subscription price, covered by the customer
    # @param skip_automations [Boolean] Skip automation enrollment (e.g. subscription_assigned). Default false.
    def create_subscription(
      id:,
      product_id:,
      with_manual_billing: nil,
      perform_action_at: nil,
      currency: nil,
      cover_fees: nil,
      skip_automations: nil
    )
      request(:post, "#{PATH}/#{id}/subscription", body: {
        product_id: product_id,
        with_manual_billing: with_manual_billing,
        perform_action_at: perform_action_at,
        currency: currency,
        cover_fees: cover_fees,
        skip_automations: skip_automations
      })
    end

    # Cancel a customer's active subscription
    # @param id [Integer] Customer ID or Email
    def cancel_subscription(id:)
      request(:delete, "#{PATH}/#{id}/subscription")
    end

    private

    def not_found_error
      UscreenAPI::Errors::UserNotFound
    end

    def unprocessable_entity_error
      UscreenAPI::Errors::UserNotCreated
    end
  end
end
