# Extensis Portfolio

A simple wrapper for the Extensis Portfolio API, which uses both SOAP and HTTP.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'extensis_portfolio'
```

And then run:

    $ bundle

Or install it yourself as:

    $ gem install extensis_portfolio

## Usage

Create a connection to the Extensis Portfolio API:

```ruby
connection = ExtensisPortfolio::Connection.new(server, username, password)
```

Where server is the url including port, without any suffixes e.g. `http://demo.extensis.com:8090`

Return a list of available SOAP operations:

```ruby
connection.get_soap_operations
```

Download an asset:

```ruby
ExtensisPortfolio::AssetDownloader.new(connection, asset_id, catalog_id).download_file
```

## Testing

The gem comes with a MiniTest / Guard test suite, simply run:

    $ bundle install

Followed by:

    $ bundle exec guard

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/tomasc/extensis_portfolio/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
