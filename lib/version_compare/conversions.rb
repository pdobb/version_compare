# Conversions is meant to be a common module used to define standard conversion
# methods. Anytime one of the standard conversion methods are needed, the
# Conversions module can be included and then used freely.
module Conversions
  require_relative "version"

  # The `Version()` conversion method is defined as a module_function so that it
  # may also be called directly without needing to include the Conversions module
  # if so desired.
  #
  # @example
  #   Conversions.Version(1.2).to_s # => "1.2"
  module_function

  # Strict conversion method for creating a `Version` object out of anything
  # that sensibly is a Version.
  #
  # @param [Object] value the object to be converted
  #
  # @example
  #   Version(1) # => #<Version:0x007fd8144ea658 @major=1, @minor=nil, @tiny=nil, @patch=nil>
  #   Version(1.2) # => #<Version:0x007fd8144ea658 @major=1, @minor=2, @tiny=nil, @patch=nil>
  #   Version("1.2.3") # => #<Version:0x007fd8144ea658 @major=1, @minor=2, @tiny=3, @patch=nil>
  #   Version(["1", "2", "3", "4"]) # => #<Version:0x007fd8144f98b0 @major=1, @minor=2, @tiny=3, @patch=4>
  def Version(value)
    case value
    when String,
         Integer,
         Float,
         -> val { val.respond_to?(:to_ary) }
      Version.new(value)
    when -> val { val.respond_to?(:to_version) }
      value.to_version
    else
      raise TypeError, "Cannot convert #{value.inspect} to Version"
    end
  end
end
