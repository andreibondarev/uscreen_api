# frozen_string_literal: true

module UscreenAPI::Errors
  class Error < StandardError; end

  class Unauthorized < Error; end

  class NotFound < Error; end

  class UnprocessableEntity < Error; end

  # Raised by customer endpoints. Kept for backwards compatibility.
  class UserNotFound < NotFound; end

  class UserNotCreated < UnprocessableEntity; end
end
