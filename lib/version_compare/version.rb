class Version
  include Comparable

  # Version component names
  NAMES = [:major, :minor, :tiny, :patch].freeze

  attr_accessor *NAMES

  def initialize(value)
    @major, @minor, @tiny, @patch = begin
      if value.respond_to?(:to_ary)
        value.to_ary.map(&:to_i)
      elsif value.respond_to?(:to_version)
        value.to_version.to_a
      else
        value.to_s.split('.').map(&:to_i)
      end
    end
  end

  # Implicit conversion method
  def to_version
    self
  end

  def to_s
    [major, minor, tiny, patch].compact.join('.')
  end
  alias :to_str :to_s

  def to_f
    to_s.to_f
  end

  def to_a
    NAMES.map { |name| send(name) }.compact
  end
  alias :to_ary :to_a

  # Version components comparison method. Uses Comparable to assess whether
  # This Version's component value or the other Version's component value is
  # greater or lesser. The first value to be found as greater or lesser
  # determines which Version object is greater or lesser.
  #
  # Missing Version components are treated as 0 values, which effectively gives
  # them no weight in the comparison.
  #
  # @params [Version] other the other Version object we are comparing with
  def <=>(other)
    NAMES.each do |name|
      result = send(name).to_i <=> other.send(name).to_i
      return result unless result.zero?
    end
    0
  end
end
