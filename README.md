# Version Compare

[![Gem Version](https://badge.fury.io/rb/version_compare.png)](http://badge.fury.io/rb/version_compare)

Version Compare allows you to easily compare if one Version (string) to another
Version (string). It aims to be as light and flexible as possible. Inputs can be
a String, Integer, Float, Array, or any object that defines `#to_comparable_version`.

For simplicity's sake, Version Compare only works with up to four numeric
values:

```ruby
"<major>.<minor>.<tiny>.<patch>"
[<major>, <minor>, <tiny>, <patch>]
```


## Compatibility

Tested with:

* Ruby: MRI 1.9.3
* Ruby: MRI 2+


## Installation

Add this line to your application's Gemfile:

```ruby
gem "version_compare"
```

And then execute:

```ruby
bundle
```


## Usage

To get started, you can either use `ComparableVersion.new(<value>)` or `ComparableVersion(<value>)`.
To get the latter to work, you'll need to call `include ::Conversions` in the
class or context you're wanting to use it at.

```ruby
class MyClass
  include Conversions

  def my_method
    ComparableVersion(1) > ComparableVersion(2)
  end
end
```

Or, to test on the Rails Console:

```ruby
[1] pry(main)> include ::Conversions
=> Object
[2] pry(main)> ComparableVersion(1.0) > ComparableVersion(1)
=> false

# - OR (without using `include ::Conversions`) -

[1] pry(main)> Conversions.ComparableVersion(1.0) > Conversions.ComparableVersion(1)
=> false
```

ComparableVersion Compare uses the `Comparable` mixin for comparisons, so you get all the
usual operators:

```ruby
ComparableVersion(2) > ComparableVersion(1) # => true
ComparableVersion(1.2) > ComparableVersion(1.2) # => false
ComparableVersion("1.2.3") >= ComparableVersion("1.2") # => true
ComparableVersion("1.2.3.4") <= ComparableVersion("1.2.3.4") # => true
ComparableVersion([1, 2]) == ComparableVersion(["1", "2"]) # => true
ComparableVersion("1.2.0.0") == ComparableVersion(1.2) # => true
ComparableVersion("1.0.0.0") != ComparableVersion(1) # => false
[ComparableVersion(1), ComparableVersion("1.0.0.1"), ComparableVersion(0.1)].sort # => ["0.1", "1", "1.0.0.1"]
[ComparableVersion(1), ComparableVersion("1.0.0.1"), ComparableVersion(0.1)].sort { |a, b| b <=> a } # => ["1.0.0.1", "1", "0.1"]
```


### Wait, so what exactly is this `ComparableVersion` ... constant?

`ComparableVersion()` is actually a conversion function. It follows the Ruby convention of
defining a conversion function that uses the same name as the class it
represents, such as how `Array()` converts inputs to an `Array` object.
Just like the standard Ruby conversion functions, `ComparableVersion()` tries its hardest
to convert any ComparableVersion-like input into a new `ComparableVersion` object. Given a numeric,
string, or array input (which are all obvious conversions to make), `ComparableVersion()`
is essentially the same as `ComparableVersion.new()`. However, `ComparableVersion()` is otherwise a
little more strict in that if you pass in an object that doesn't reasonably look
like a ComparableVersion it will raise a `TypeError` exception. Doing the same for
`ComparableVersion.new()` will ultimately just `#to_s` the input; and since almost
every object responds to `#to_s`, the result is that you may end up with a 0
version. For example:

```ruby
ComparableVersion.new(OpenStruct.new(a: 1)).to_s # => "0"
```


### Can I pass my own custom objects into `ComparableVersion()`?

Yes! All you have to do is define a `#to_comparable_version` implicit conversion method in
your object that creates a new ComparableVersion object in the usual fashion.

```ruby
class MyObject
  VERSION = 1.9
  def to_comparable_version
    ComparableVersion.new(VERSION.to_s)
  end
end

ComparableVersion(MyObject.new) > ComparableVersion(2.0) # => false
```


### Why do you seem so excited about the custom object thing?

Because, it opens up the world! Here's an example:

```ruby
# Given a Rails app:

# /config/application.rb
module Dummy
  class Application < Rails::Application
    # ...

    VERSION = "1.2".freeze

    def to_comparable_version
      ComparableVersion.new(VERSION) # Or ComparableVersion.new([1, 2]) or whatever...
    end
  end
end

# Now, from the context of that Rails app you can call:
ComparableVersion(Rails.application) > ComparableVersion(1.0) # => true
```

So you see... the sky is the limit!


## Author

- Paul Dobbins
