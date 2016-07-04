class ComparableVersion
  DEFAULT_SEPARATOR = ".".freeze

  include Comparable

  # ComparableVersion component names
  NAMES = [:major, :minor, :tiny, :patch].freeze

  attr_accessor *NAMES
  attr_reader :separator

  def initialize(value, options = {})
    @separator = options.fetch(:separator) { DEFAULT_SEPARATOR }

    @major, @minor, @tiny, @patch =
      if value.respond_to?(:to_comparable_version)
        value.to_comparable_version.to_a
      elsif value.respond_to?(:to_ary)
        value.to_ary.map(&:to_i)
      else
        value.to_s.split(separator).map(&:to_i)
      end
  end

  def inspect
    "<#{identification}>"
  end

  # Implicit conversion method
  def to_comparable_version
    self
  end

  def to_s
    NAMES.map { |name| public_send(name) }.compact.join(separator)
  end
  alias :to_str :to_s

  def to_a
    NAMES.map { |name| public_send(name) }.compact
  end
  alias :to_ary :to_a

  # ComparableVersion components comparison method. Uses Comparable to assess whether
  # This ComparableVersion's component value or the other ComparableVersion's component value is
  # greater or lesser. The first value to be found as greater or lesser
  # determines which ComparableVersion object is greater or lesser.
  #
  # Missing ComparableVersion components are treated as 0 values, which effectively gives
  # them no weight in the comparison.
  #
  # @params [ComparableVersion] other the other ComparableVersion object we are comparing with
  def <=>(other)
    NAMES.each do |name|
      result = send(name).to_i <=> other.send(name).to_i
      return result unless result.zero?
    end

    0
  end
end
