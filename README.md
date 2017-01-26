# CspBuilder

Content Security Policy string builder. Create rich Content Security
Policies using this easy to use builder class.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csp_builder'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csp_builder

## Usage

Here is a quick example. Please see the
[docs](http://www.rubydoc.info/github/SimplyBuilt/csp_builder) for more
details!


```ruby
csp = CspBuilder.new.
  script_src("https://*.cloudfront.net", :self).
  style_src("https://*.cloudfront.net").
  img_src('*').
  frame_ancestors(:self).
  upgrade_insecure_requests

# Get the compiled CSP string:
# "script-src https://*.cloudfront.net 'self'; style-src https://*.cloudfront.net; img-src *; frame-ancestors 'self'; upgrade-insecure-requests"
csp.compile!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the
`.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/[SimplyBuilt]/csp_builder. This project is intended
to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor
Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).
