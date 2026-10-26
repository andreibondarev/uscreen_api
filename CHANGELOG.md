## [Unreleased]
- Require Ruby >= 3.2 (Ruby 3.0 and 3.1 are EOL); test against Ruby 3.2, 3.3, 3.4 and 4.0.
- Add groups, contents, programs, videos, offers, invoices, email topics and analytics endpoints.
- Add customers.access, customers.subscription, customers.create_subscription and customers.cancel_subscription.
- Add new customer params: opted_in_for_community_updates, legacy_id, tags, unsubscribed_topic_ids, payment_user_id (update), skip_automations (grant_access).
- Fix customers.accesses ignoring page/from/to.
- Fix false boolean params (e.g. opted_in_for_news_and_updates: false) being dropped from requests.
- Raise generic UscreenAPI::Errors::Error on other 4xx/5xx responses; add NotFound and UnprocessableEntity base errors.
- Memoize the Faraday connection and allow configuring the Faraday adapter.

## [0.1.2] - 2024-03-28
- customers.grant_access(product_type:) param is not required.

## [0.1.1] - 2024-01-08
- Fix customers.create() method

## [0.1.0] - 2024-01-07

- Initial release
