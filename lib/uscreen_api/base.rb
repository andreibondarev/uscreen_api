# frozen_string_literal: true

module UscreenAPI
  class Base
    attr_reader :client

    def initialize(client:)
      @client = client
    end

    private

    # Perform a request and return the parsed response body.
    # Keys with nil values are dropped from params and body so optional arguments are only sent when given.
    def request(method, path, params: {}, body: nil)
      response = client.connection.public_send(method, path) do |req|
        req.params.update(compact(params))
        req.body = compact(body) if body
      end

      handle_errors(response.status, response.body)

      response.body
    end

    def compact(hash)
      hash.reject { |_, value| value.nil? }
    end

    def not_found_error
      UscreenAPI::Errors::NotFound
    end

    def unprocessable_entity_error
      UscreenAPI::Errors::UnprocessableEntity
    end

    def handle_errors(status, body)
      case status
      when 401 then raise UscreenAPI::Errors::Unauthorized.new(body)
      when 404 then raise not_found_error.new(body)
      when 422 then raise unprocessable_entity_error.new(body)
      when 400..599 then raise UscreenAPI::Errors::Error.new(body)
      end
    end
  end
end
