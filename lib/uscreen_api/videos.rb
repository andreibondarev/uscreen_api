# frozen_string_literal: true

module UscreenAPI
  class Videos < Base
    PATH = "videos"

    # Get paginated list of videos
    # @param page [Integer] Page number
    # @param include [String] Comma-separated list of relationships to include. Available relationships: author.
    # @param from [String] Starting date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    def list(page: nil, include: nil, from: nil, to: nil)
      request(:get, PATH, params: {page: page, include: include, from: from, to: to})
    end

    # Get video by ID
    # @param id [String] Video ID
    # @param include [String] Comma-separated list of relationships to include. Available relationships: author.
    def get(id:, include: nil)
      request(:get, "#{PATH}/#{id}", params: {include: include})
    end
  end
end
