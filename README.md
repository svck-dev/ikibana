# Ikibana

This is a work in progress.

Ikibana is a simple and easy to use Rails background job runner that uses NATS JetStream as a message broker.
Just like `sidekiq` or `sneakers`, but allowing to create distributed applications or microservices with ease.

## Usage

To install:

```bash
  gem install ikibana
```

Or add this line to your application's Gemfile:

```ruby
  gem 'ikibana'
```

Then in a Rails application context execute

```bash
  bundle exec rails g ikibana:install
```

This will create a `config/initializers/ikibana.rb` file alongside with `config/nats.yaml` file with the default
configuration.
At the moment there are only two options available for configuration:

* logger: The logger to use. Defaults to `Logger.new`.
*
    * this can be replaced with any logger that responds to `info`, `warn`, `error` and `debug` methods.
* cache: The cache to use. Defaults to none.
*
    * there is a class that can be inherited for implementing your own cache `Ikibana::ICache`.
*
    * the cache at the moment has to respond to `write` and `read` methods
*
    *
        * can be replaced with `Rails.cache` at the moment

## Features

* Generation of consumers: `rails g ikibana:consumer <name>` where name can be any ruby constant identifier.
*
    * for example `rails g ikibana:consumer A::B::C` will generate a consumer `A::B::CConsumer` that will listen to the
      `a.b.c` subject.
*
    * The consumer has one private method `perform(msg)` that will be called when a message is received. This is where
      you will implement your application logic.
* Producer: At the moment the only way to produce messages would be
  `Ikibana::Config.instance.js.publish(subject, payload)`
*
    * This will be replaced with a more user-friendly and idiomatic way of producing messages in the future.

## Roadmap

| Feature Name                           | Status                                                  |
|----------------------------------------|---------------------------------------------------------|
| Generation of consumers                | Implemented                                             |
| Logger configuration                   | Implemented                                             |
| Cache configuration                    | To be improved(NATS k/v storage instead of Rails cache) |
| Consumer placement mechanism           | To be implemented                                       |
| Consumer type(sync/async/at_most_once) | To be implemented                                       |
| CLI to start all the consumers         | To be implemented                                       |
| Producer DSL                           | To be implemented                                       |
| Producer configuration                 | To be implemented                                       |
| Test coverage                          | To be implemented                                       |
| Documentation                          | To be improved                                          |
| Examples                               | To be implemented                                       |
| Complete Rails integration             | To be implemented                                       |
| Stand alone mode                       | To be implemented                                       |