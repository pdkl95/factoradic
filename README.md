# Factoradic

Factorial base integer conversion.

[https://en.wikipedia.org/wiki/Factorial_number_system](https://en.wikipedia.org/wiki/Factorial_number_system)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'factoradic'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install factoradic

## Usage

### The command line utility

#### Options

    Usage: exe/factoradic [options] <number> [...]

    OPTIONS
      -i, --input=BASE         Interpret input strings in <BASE> format
                               (valid bases: d, f, decimal, factorial)
      -o, --output=BASE        Print converted numbers in <BASE> format
                               (valid bases: d, f, decimal, factorial)

          --d2f                Shorthand for --input=decimal --output=factorial
          --f2d                Shorthand for --input=factorial --output=decimal

      -s, --separator=CHAR     Use <CHAR> as the factorial base position separator
                               (default: ":")
          --[no-]cache         Enable/disable caching calculated factorial values.
                               (default: On)

      -h, --help               Show this help message
          --version            Show version

#### Examples

    $ factoradic 5:4:3:2:1:0
    719

    $ factoradic 1:0:0:0:0:0:0
    720

    $ factoradic 463
    3:4:1:0:1:0

    $ factoradic --separator=',' 463
    3,4,1,0,1,0

    $ echo 1:3:0:0:0 | factoradic --f2d -
    42

    $ ( echo 719 ; echo 720 ) | factoradic --d2f -
    5:4:3:2:1:0
    1:0:0:0:0:0:0


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pdkl95/factoradic.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
