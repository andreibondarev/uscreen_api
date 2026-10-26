# UscreenAPI

Client library for the [Uscreen.tv](https://www.uscreen.tv/) APIs.

![Tests status](https://github.com/andreibondarev/uscreen_api/actions/workflows/ci.yml/badge.svg)
[![Gem Version](https://badge.fury.io/rb/uscreen_api.svg)](https://badge.fury.io/rb/uscreen_api)
[![Docs](http://img.shields.io/badge/yard-docs-blue.svg)](http://rubydoc.info/gems/uscreen_api)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/andreibondarev/uscreen_api/blob/main/LICENSE.txt)

## Installation

```bash
gem install uscreen_api
```

## Usage

```ruby
require "uscreen_api"

client = UscreenAPI::Client.new(api_key: ENV["USCREEN_API_KEY"])

client.customers.list(page: 1)
client.customers.create(email: "joe@example.com", name: "Joe Shmoe", skip_invite: true)
client.customers.get(id: "joe@example.com")
client.customers.grant_access(id: 123, product_id: 456, product_type: "recurring")
client.customers.create_subscription(id: 123, product_id: 789)
client.contents.list(content_type: "video", include: "author")
client.analytics.video_views(user_id: 123)
```

Supported resources, matching the [Publisher API](https://www.uscreen.io/api/publisher.html):

| Resource | Methods |
| --- | --- |
| `customers` | `list`, `create`, `get`, `update`, `tokenized_url`, `accesses`, `access`, `grant_access`, `revoke_access`, `subscription`, `create_subscription`, `cancel_subscription` |
| `groups` | `list`, `create`, `delete`, `members`, `add_member`, `remove_member` |
| `contents` | `list`, `get`, `playlist_items`, `playlist_item`, `publish`, `unpublish`, `schedule` |
| `programs` (legacy alias of contents) | `list`, `get`, `chapters`, `chapter` |
| `videos` | `list`, `get` |
| `offers` | `list`, `get` |
| `invoices` | `list`, `get` |
| `email_topics` | `list` |
| `analytics` | `video_views`, `total_watch_time`, `video_views_summary` |

Errors raise subclasses of `UscreenAPI::Errors::Error`: `Unauthorized` (401), `NotFound` (404), `UnprocessableEntity` (422). Customer endpoints raise `UserNotFound` / `UserNotCreated`, which subclass `NotFound` / `UnprocessableEntity`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/andreibondarev/uscreen_api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
