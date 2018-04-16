module VersionCompare
  # Conversions is meant to be a common module used to define standard
  # conversion methods. Anytime one of the standard conversion methods are
  # needed, the Conversions module can be included and then used freely.
  module Conversions

  module_function

    # Strict conversion method for creating a `ComparableVersion` object out of
    # anything that can be interpreted is a ComparableVersion.
    #
    # @param [Object] value the object to be converted
    #
    # @example
    #   ComparableVersion(1)
    #   # => #<ComparableVersion @major=1, @minor=nil, @tiny=nil, @patch=nil>
    #
    #   ComparableVersion(1.2)
    #   # => #<ComparableVersion @major=1, @minor=2, @tiny=nil, @patch=nil>
    #
    #   ComparableVersion("1.2.3")
    #   # => #<ComparableVersion @major=1, @minor=2, @tiny=3, @patch=nil>
    #
    #   ComparableVersion(["1", "2", "3", "4"])
    #   # => #<ComparableVersion @major=1, @minor=2, @tiny=3, @patch=4>
    def ComparableVersion(value)
      case value
      when String,
           Integer,
           Float,
           -> val { val.respond_to?(:to_ary) }
        ComparableVersion.new(value)
      when -> val { val.respond_to?(:to_comparable_version) }
        value.to_comparable_version
      else
        raise TypeError, "Cannot convert #{value.inspect} to ComparableVersion"
      end
    end
  end
end
