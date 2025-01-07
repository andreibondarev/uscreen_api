# frozen_string_literal: true

require "faraday"

module UscreenAPI
  class Client
    attr_reader :api_key

    BASE_URL = "https://www.uscreen.io/publisher_api/v1/"

    def initialize(api_key:)
      @api_key = api_key
    end

    def customers
      @customers ||= UscreenAPI::Customers.new(client: self)
    end

    def connection
      @connection = Faraday.new(
        url: BASE_URL,
        headers: {
          "Content-Type": "application/json",
          Authorization: api_key
        }
      ) do |f|
        f.request(:json)
        f.response(:json)
      end
    end
  end
end
