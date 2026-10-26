# frozen_string_literal: true

module UscreenAPI
  class Invoices < Base
    PATH = "invoices"

    # Get paginated list of invoices
    # @param page [Integer] Page number
    # @param from [String] Starting date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param date_field [String] Date field to filter by. Available fields: created_at, updated_at. Default: created_at.
    def list(page: nil, from: nil, to: nil, date_field: nil)
      request(:get, PATH, params: {page: page, from: from, to: to, date_field: date_field})
    end

    # Get invoice by ID
    # @param id [String] Invoice ID
    def get(id:)
      request(:get, "#{PATH}/#{id}")
    end
  end
end
