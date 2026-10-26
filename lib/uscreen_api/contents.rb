# frozen_string_literal: true

module UscreenAPI
  class Contents < Base
    PATH = "contents"

    # Get paginated list of contents (videos, collections and live events)
    # @param page [Integer] Page number
    # @param include [String] Comma-separated list of relationships to include. Available relationships: author.
    # @param from [String] Starting date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param to [String] Ending date and time for the filter range, formatted in RFC 3339. Example: 2023-01-01T00:00:00Z
    # @param content_type [String] Filter by content type. Can be collection|live_event|video
    def list(page: nil, include: nil, from: nil, to: nil, content_type: nil)
      request(:get, PATH, params: {page: page, include: include, from: from, to: to, content_type: content_type})
    end

    # Get content information (video, collection or live event)
    # @param id [String] Content ID
    # @param include [String] Comma-separated list of relationships to include. Available relationships: author.
    def get(id:, include: nil)
      request(:get, "#{PATH}/#{id}", params: {include: include})
    end

    # Get list of playlist items (formerly known as chapters) and file resources
    # @param id [String] Content ID
    def playlist_items(id:)
      request(:get, "#{PATH}/#{id}/playlist_items")
    end

    # Get a playlist item (formerly known as chapter)
    # @param id [String] Content ID
    # @param playlist_item_id [String] Playlist item ID
    def playlist_item(id:, playlist_item_id:)
      request(:get, "#{PATH}/#{id}/playlist_items/#{playlist_item_id}")
    end

    # Publish a video, collection or live event
    # @param id [String] Content ID
    # @param event_launch_datetime [String] Live events only. Launch date and time in the future, formatted in RFC 3339. Example: 2025-06-01T12:00:00Z
    def publish(id:, event_launch_datetime: nil)
      request(:post, "#{PATH}/#{id}/visibility/publish", params: {event_launch_datetime: event_launch_datetime})
    end

    # Unpublish a video, collection or live event
    # @param id [String] Content ID
    def unpublish(id:)
      request(:post, "#{PATH}/#{id}/visibility/unpublish")
    end

    # Schedule a video or collection for future publication
    # @param id [String] Content ID
    # @param scheduled_datetime [String] Publication date and time in the future, formatted in RFC 3339. Example: 2025-06-01T12:00:00Z
    # @param schedule_published [Boolean] Allow scheduling content that is currently published. It will be unpublished and scheduled.
    def schedule(id:, scheduled_datetime:, schedule_published: nil)
      request(:post, "#{PATH}/#{id}/visibility/schedule", params: {
        scheduled_datetime: scheduled_datetime,
        schedule_published: schedule_published
      })
    end
  end
end
