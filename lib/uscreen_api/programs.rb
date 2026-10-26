# frozen_string_literal: true

module UscreenAPI
  # Programs are the legacy name for contents. Prefer UscreenAPI::Contents.
  class Programs < Base
    PATH = "programs"

    # Get paginated list of programs
    # @param page [Integer] Page number
    # @param include [String] Comma-separated list of relationships to include. Available relationships: author.
    # @param from [String] Starting date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param content_type [String] Filter by content type. Can be collection|live_event|video
    def list(page: nil, include: nil, from: nil, to: nil, content_type: nil)
      request(:get, PATH, params: {page: page, include: include, from: from, to: to, content_type: content_type})
    end

    # Get a program information
    # @param id [String] Program ID
    # @param include [String] Comma-separated list of relationships to include. Available relationships: author.
    def get(id:, include: nil)
      request(:get, "#{PATH}/#{id}", params: {include: include})
    end

    # Get list of chapters
    # @param id [String] Program ID
    def chapters(id:)
      request(:get, "#{PATH}/#{id}/chapters")
    end

    # Get a chapter
    # @param id [String] Program ID
    # @param chapter_id [String] Chapter ID
    def chapter(id:, chapter_id:)
      request(:get, "#{PATH}/#{id}/chapters/#{chapter_id}")
    end
  end
end
