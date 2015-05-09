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

Get a list of available SOAP operations:

```ruby
connection.get_soap_operations
```

### Downloading an asset

Download an asset:

```ruby
ExtensisPortfolio::AssetDownloader.new(connection, asset_id, catalog_id).download_file
```

### Querying

You can query for assets on a connection with the `get_assets` method. The query is built in two steps.

First you create an `ExtensisPortfolio::AssetQueryTerm`:

```ruby
# AssetQueryTerm takes three parameters: "field_name", "operator" and "values"
# this query is for an asset where the "asset_id" field is equal to 1234
query_term = ExtensisPortfolio::AssetQueryTerm.new("asset_id", "equalValue", 1234)
```

[Available value operators](http://doc.extensis.com/api/portfolio/assets_queryOperator.html)

The `asset_query_term` is then used to build a new instance of `ExtensisPortfolio::AssetQuery`:

```ruby
query = ExtensisPortfolio::AssetQuery.new(query_term)
```

Which is finally used in the `get_assets` call:

```ruby
# get_assets takes three parameters: catalog_id, query and an optional options hash
connection.get_assets(catalog_id, query)
```

## Testing

The gem comes with a MiniTest / Guard test suite, simply run:

    $ bundle install

Followed by:

    $ bundle exec guard

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Notes
API fails:
* `getJobIDs` should be `getJobIds`, this is the only place where `id` is with capital D... Means that `Savon` call has to be `get_job_i_ds`

## Contributing

1. Fork it ( https://github.com/tomasc/extensis_portfolio/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
