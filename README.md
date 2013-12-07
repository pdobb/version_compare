# Version Compare

[![Gem Version](https://badge.fury.io/rb/version_compare.png)](http://badge.fury.io/rb/version_compare)

Version Compare allows you to easily compare if one Version (string) to another
Version (string). It aims to be as light and flexible as possible. Inputs can be
a String, Integer, Float, Array, or any object that defines `#to_version`.

In an effort to remain simple, Version Compare only works with up to four
numeric values separated by periods:

```ruby
"<major>.<minor>.<tiny>.<patch>"
```

## Compatibility

Tested with:

* Ruby: MRI 1.9.3
* Ruby: MRI 2.0.0 +

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

To get started, you can either use `Version.new(<value>)` or `Version(<value>)`.
To get the latter to work, you'll need to call `include ::Conversions` in the
class or context you're wanting to use it at.

```ruby
class MyClass
  include Conversions

  def my_method
    Version(1) > Version(2)
  end
end
```

Or, to test on the Rails Console:

```ruby
[1] pry(main)> include ::Conversions
=> Object
[2] pry(main)> Version(1.0) > Version(1)
=> false

# - OR (without using `include`) -

[1] pry(main)> Conversions.Version(1.0) > Conversions.Version(1)
=> false
```

Version Compare uses the `Comparable` mixin for comparisons, so you get all the
usual operators:

```ruby
Version(2) > Version(1) # => true
Version(1.2) > Version(1.2) # => false
Version("1.2.3") >= Version("1.2") # => true
Version("1.2.3.4") <= Version("1.2.3.4") # => true
Version([1, 2]) == Version(["1", "2"]) # => true
Version("1.2.0.0") == Version(1.2) # => true
Version("1.0.0.0") != Version(1) # => false
[Version(1), Version("1.0.0.1"), Version(0.1)].sort # => ["0.1", "1", "1.0.0.1"]
[Version(1), Version("1.0.0.1"), Version(0.1)].sort { |a, b| b <=> a } # => ["1.0.0.1", "1", "0.1"]
```

### Wait, so what exactly is this `Version` ... constant?

`Version()` is actually a conversion function. It follows the Ruby convention of
defining a conversion function that uses the same name as the class it
represents, such as how `Array()` converts inputs to an `Array` object.
Just like the standard Ruby conversion functions, `Version()` tries its hardest
to convert any Version-like input into a new `Version` object. Given a numeric,
string, or array input (which are all obvious conversions to make), `Version()`
is essentially the same as `Version.new()`. However, `Version()` is otherwise a
little more strict in that if you pass in an object that doesn't reasonably look
like a Version it will raise a `TypeError` exception. Doing the same for
`Version.new()` will ultimately just `#to_s` the input; and since almost
every object responds to `#to_s`, the result is that you may end up with a 0
version. For example:

```ruby
Version.new(OpenStruct.new(a: 1)).to_s # => "0"
```

### Can I pass my own custom objects into `Version()`?

Yes! All you have to do is define a `#to_version` implicit conversion method in
your object. Just have it return either a String, an Integer, a Float, or an
Array.

```ruby
class MyObject
  VERSION = 1.9
  def to_version
    Version.new(VERSION.to_s)
  end
end

Version(MyObject.new) > Version(2.0) # => false
```

### Why do you seem to excited about the custom object thing?

Because, it opens up the world! Here's an example:

```ruby
# Given a Rails app:

# /config/application.rb
module Dummy
  class Application < Rails::Application
    # ...

    VERSION = "1.2".freeze

    def to_version
      Version.new(VERSION) # Or Version.new([1, 2]) or whatever...
    end
  end
end

# Now, from the context of that Rails app you can call:
Version(Rails.application) > Version(1.0) # => true
```

So you see, the sky is the limit...

## Author

- Paul Dobbins
