module UscreenAPI
  class Base
    attr_reader :client

    def initialize(client:)
      @client = client
    end

    private

    def handle_errors(status, body)
      case status
      when 401 then raise UscreenAPI::Errors::Unauthorized.new(body)
      when 404 then raise UscreenAPI::Errors::UserNotFound.new(body)
      when 422 then raise UscreenAPI::Errors::UserNotCreated.new(body)
      end
    end
  end
end
