# frozen_string_literal: true

module UscreenAPI::Errors
  class UserNotFound < StandardError; end

  class UserNotCreated < StandardError; end

  class Unauthorized < StandardError; end
end
