# frozen_string_literal: true

require "faraday"

module UscreenAPI
  class Client
    attr_reader :api_key, :adapter

    BASE_URL = "https://www.uscreen.io/publisher_api/v1/"

    # @param api_key [String] Publisher API key
    # @param adapter [Symbol, Array] Faraday adapter, optionally followed by its arguments. Example: [:test, stubs]
    def initialize(api_key:, adapter: Faraday.default_adapter)
      @api_key = api_key
      @adapter = adapter
    end

    def analytics
      @analytics ||= UscreenAPI::Analytics.new(client: self)
    end

    def contents
      @contents ||= UscreenAPI::Contents.new(client: self)
    end

    def customers
      @customers ||= UscreenAPI::Customers.new(client: self)
    end

    def email_topics
      @email_topics ||= UscreenAPI::EmailTopics.new(client: self)
    end

    def groups
      @groups ||= UscreenAPI::Groups.new(client: self)
    end

    def invoices
      @invoices ||= UscreenAPI::Invoices.new(client: self)
    end

    def offers
      @offers ||= UscreenAPI::Offers.new(client: self)
    end

    def programs
      @programs ||= UscreenAPI::Programs.new(client: self)
    end

    def videos
      @videos ||= UscreenAPI::Videos.new(client: self)
    end

    def connection
      @connection ||= Faraday.new(
        url: BASE_URL,
        headers: {
          "Content-Type": "application/json",
          Authorization: api_key
        }
      ) do |f|
        f.request(:json)
        f.response(:json)
        f.adapter(*Array(adapter))
      end
    end
  end
end
