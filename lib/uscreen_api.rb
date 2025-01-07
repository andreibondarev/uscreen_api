# frozen_string_literal: true

require_relative "uscreen_api/version"

module UscreenAPI
  autoload :Base, "uscreen_api/base"
  autoload :Client, "uscreen_api/client"
  autoload :Customers, "uscreen_api/customers"
  autoload :Errors, "uscreen_api/errors"
end
