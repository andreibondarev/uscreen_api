# frozen_string_literal: true

module UscreenAPI
  class Offers < Base
    PATH = "offers"

    # Get paginated list of offers
    # @param page [Integer] Page number
    # @param from [String] Starting date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    def list(page: nil, from: nil, to: nil)
      request(:get, PATH, params: {page: page, from: from, to: to})
    end

    # Get an offer information
    # @param id [String] Offer ID
    def get(id:)
      request(:get, "#{PATH}/#{id}")
    end
  end
end
