# frozen_string_literal: true

module ApiHelpers
  BASE_PATH = "/publisher_api/v1"

  def stubs
    @stubs ||= Faraday::Adapter::Test::Stubs.new
  end

  def client
    @client ||= UscreenAPI::Client.new(api_key: "123", adapter: [:test, stubs])
  end

  def fixture(name)
    File.read("spec/fixtures/#{name}.json")
  end

  # Stub a request against the Publisher API.
  # Yields the request env so examples can inspect params and body.
  def stub_api(method, path, status: 200, body: nil)
    stubs.public_send(method, "#{BASE_PATH}/#{path}") do |env|
      yield env if block_given?
      [status, {"Content-Type" => "application/json"}, body]
    end
  end

  def request_body(env)
    JSON.parse(env.request_body)
  end
end
