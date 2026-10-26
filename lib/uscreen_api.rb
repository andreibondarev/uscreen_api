# frozen_string_literal: true

require_relative "uscreen_api/version"

module UscreenAPI
  autoload :Analytics, "uscreen_api/analytics"
  autoload :Base, "uscreen_api/base"
  autoload :Client, "uscreen_api/client"
  autoload :Contents, "uscreen_api/contents"
  autoload :Customers, "uscreen_api/customers"
  autoload :EmailTopics, "uscreen_api/email_topics"
  autoload :Errors, "uscreen_api/errors"
  autoload :Groups, "uscreen_api/groups"
  autoload :Invoices, "uscreen_api/invoices"
  autoload :Offers, "uscreen_api/offers"
  autoload :Programs, "uscreen_api/programs"
  autoload :Videos, "uscreen_api/videos"
end
