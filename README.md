# Version Compare

[![Gem Version](https://badge.fury.io/rb/version_compare.svg)](https://badge.fury.io/rb/version_compare)
[![Build Status](https://travis-ci.org/pdobb/version_compare.svg?branch=master)](https://travis-ci.org/pdobb/version_compare)
[![Test Coverage](https://api.codeclimate.com/v1/badges/99cb6a37ab03e0aa246e/test_coverage)](https://codeclimate.com/github/pdobb/version_compare/test_coverage)
[![Maintainability](https://api.codeclimate.com/v1/badges/99cb6a37ab03e0aa246e/maintainability)](https://codeclimate.com/github/pdobb/version_compare/maintainability)

VersionCompare simplifies comparison of version numbers with other version numbers. It aims to be as light and flexible as possible. Inputs can be a String, Integer, Float, Array, or any object that defines `#to_comparable_version`.

For simplicity's sake, Version Compare only works with up to four numeric values.

```ruby
"<major>.<minor>.<tiny>.<patch>"
[<major>, <minor>, <tiny>, <patch>]
```


## Installation

Add this line to your application's Gemfile:

```ruby
gem "version_compare"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install version_compare


## Compatibility

Tested MRI Ruby Versions:
* 2.2.10
* 2.3.7
* 2.4.4
* 2.5.1
* edge

VersionCompare has no other dependencies.


## Usage

To get started, you can either use `ComparableVersion.new(<value>)` or `ComparableVersion(<value>)`.
To get the latter to work, you'll need to call `include VersionCompare::Conversions` in the class or context you're wanting to use it at.

```ruby
class MyObject
  include VersionCompare::Conversions

  def my_method
    ComparableVersion(1) > ComparableVersion(2)
  end
end

MyObject.new.my_method  # => false
```

Or, to test on the Rails Console:

```ruby
[1] pry(main)> include VersionCompare::Conversions  # => Object
[2] pry(main)> ComparableVersion(1.0) > ComparableVersion(1)  # => false

# - OR (without using `include VersionCompare::Conversions`) -

[1] pry(main)> VersionCompare::Conversions.ComparableVersion(1.0) > VersionCompare::Conversions.ComparableVersion(1)
# => false
```

ComparableVersion Compare uses the `Comparable` mix-in for comparisons, so you get all the usual operators:

```ruby
include VersionCompare::Conversions

ComparableVersion(2) > ComparableVersion(1)                   # => true
ComparableVersion(1.2) > ComparableVersion(1.2)               # => false
ComparableVersion("1.2.3") >= ComparableVersion("1.2")        # => true
ComparableVersion("1.2.3.4") <= ComparableVersion("1.2.3.4")  # => true
ComparableVersion([1, 2]) == ComparableVersion(["1", "2"])    # => true
ComparableVersion("1.2.0.0") == ComparableVersion(1.2)        # => true
ComparableVersion("1.0.0.0") != ComparableVersion(1)          # => false

[
  ComparableVersion(1),
  ComparableVersion("1.0.0.1"),
  ComparableVersion(0.1)
].sort.map(&:to_s)
# => ["0.1", "1", "1.0.0.1"]

[
  ComparableVersion(1),
  ComparableVersion("1.0.0.1"),
  ComparableVersion(0.1)
].sort { |a, b| b <=> a }.map(&:to_s)
# => ["1.0.0.1", "1", "0.1"]
```


### Wait, so what exactly is this `ComparableVersion` ... constant?

`ComparableVersion()` is a conversion function. It follows the Ruby convention of defining a conversion function that uses the same name as the class it represents, such as how `Array()` converts inputs to an `Array` object. Just like the standard Ruby conversion functions, `ComparableVersion()` tries its hardest to convert any ComparableVersion-like input into a new `ComparableVersion` object. Given a numeric, string, or array input (which are all obvious conversions to make), `ComparableVersion()` is essentially the same as `ComparableVersion.new()`. However, `ComparableVersion()` is otherwise a little more strict in that if you pass in an object that doesn't reasonably look like a ComparableVersion it will raise a TypeError. Doing the same for `ComparableVersion.new()` will ultimately just `#to_s` the input and, since almost every object responds to `#to_s`, the result is that you may end up with a 0 version.

```ruby
VersionCompare::ComparableVersion.new(OpenStruct.new(a: 1)).to_s  # => "0"
```


### Can I pass my own custom objects into `ComparableVersion()`?

But of course! All you have to do is define a `#to_comparable_version` implicit conversion method in your object that creates a new ComparableVersion object in the usual fashion.

```ruby
class MyObject
  VERSION = 1.9

  def to_comparable_version
    VersionCompare::ComparableVersion.new(VERSION.to_s)
  end
end

include VersionCompare::Conversions

ComparableVersion(MyObject.new) > ComparableVersion(2.0)  # => false
```


### Why do you seem so excited about the custom object thing?

Because, objects should be [open for extension, but closed for modification](https://en.wikipedia.org/wiki/Open/closed_principle).

```ruby
# Given a Rails app:

# /config/application.rb
module MyRailsApp
  class Application < Rails::Application
    # ...

    VERSION = "1.2".freeze

    def to_comparable_version
      VersionCompare::ComparableVersion.new(VERSION)
    end
  end
end

# Now, from the context of that Rails app you can call:
include VersionCompare::Conversions

ComparableVersion(Rails.application) > ComparableVersion(1.0)  # => true
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pdobb/version_compare.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
