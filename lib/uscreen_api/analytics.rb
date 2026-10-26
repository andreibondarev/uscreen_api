# frozen_string_literal: true

module UscreenAPI
  class Analytics < Base
    PATH = "analytics/videos/views"

    # Get details on video views for a user, video, collection or live event. Default range: last 12 months.
    # @param page [Integer] Page number
    # @param per_page [Integer] Number of results per page (default 10, max 100)
    # @param user_id [String] User ID or Email
    # @param content_id [String] Video, Collection or Live Event ID
    # @param from [String] Starting date and time, formatted in RFC 3339. Must be within last 12 months. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    def video_views(page: nil, per_page: nil, user_id: nil, content_id: nil, from: nil, to: nil)
      request(:get, PATH, params: {
        page: page,
        per_page: per_page,
        user_id: user_id,
        content_id: content_id,
        from: from,
        to: to
      })
    end

    # Get the total video watch time for a user, video, collection or live event. Default range: last 12 months.
    # @param user_id [String] User ID or Email
    # @param content_id [String] Video, Collection or Live Event ID
    # @param from [String] Starting date and time, formatted in RFC 3339. Must be within last 12 months. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    def total_watch_time(user_id: nil, content_id: nil, from: nil, to: nil)
      request(:get, "#{PATH}/total_watch_time", params: {user_id: user_id, content_id: content_id, from: from, to: to})
    end

    # Get video view counts and total watch time grouped by user and video. Default range: last 12 months.
    # @param page [Integer] Page number
    # @param per_page [Integer] Number of results per page (default 50, max 100)
    # @param from [String] Starting date and time, formatted in RFC 3339. Must be within last 12 months. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    def video_views_summary(page: nil, per_page: nil, from: nil, to: nil)
      request(:get, "#{PATH}/summary", params: {page: page, per_page: per_page, from: from, to: to})
    end
  end
end
