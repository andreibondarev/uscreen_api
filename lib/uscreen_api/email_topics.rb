# frozen_string_literal: true

module UscreenAPI
  class EmailTopics < Base
    PATH = "email_topics"

    # Get the list of email topics
    # @param page [Integer] Page number
    def list(page: nil)
      request(:get, PATH, params: {page: page})
    end
  end
end
