# RSpecParallelGoGoGo

Run parallel_rspec with progress bar.
This gem uses parallel_tests.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rspec-parallel-go-go-go'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rspec-parallel-go-go-go

## Usage


write .rspec_parallel

```
--format RSpec::Parallel::GoGoGo::Formatter
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fukurose/rspec-parallel-go-go-go. 

After checking out the repository, you need to install dependencies:
```
gem install bundler -v 2.3.7
bundle install
```

To install this gem on your local machine, run `bundle exec rake install`.
Please check your contributions with RuboCop by running `bundle exec rubocop`.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
