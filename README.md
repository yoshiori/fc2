# LocalCache

Very simple file cahce.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "local_cache"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install local_cache

## Usage

```ruby
hoge = LocalCache.fetch do
  value_of_something
end
```

or

```
class Foo
  include LocalCache

  use_cache def bar
    baz
  end

  def baz
    "baz"
  end
end

Foo.new.bar # create cache
Foo.new.bar # Use cache(Dot call baz method)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
