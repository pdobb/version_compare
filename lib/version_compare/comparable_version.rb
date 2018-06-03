module VersionCompare
  # VersionCompare::ComparableVersion objects compare themselves with other
  # VersionCompare::ComparableVersion objects.
  #
  # @attr value [#to_comparable_version, #to_ary, #to_s] the Version object
  class ComparableVersion
    DEFAULT_SEPARATOR = ".".freeze
    NAMES = %i[major minor tiny patch].freeze

    include Comparable

    attr_accessor(*NAMES)
    attr_reader :separator

    def initialize(value, separator: DEFAULT_SEPARATOR)
      @separator = separator

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

    # Implicit conversion method.
    #
    # @return [VersionCompare::ComparableVersion] self
    def to_comparable_version
      self
    end

    # @return [String] a String representation of the version
    def to_s
      NAMES.map { |name| public_send(name) }.compact.join(separator)
    end
    alias_method :to_str, :to_s

    # @return [Array] an Array representation of the version's parts
    def to_a
      NAMES.map { |name| public_send(name) }.compact
    end
    alias_method :to_ary, :to_a

    # ComparableVersion components comparison method. Uses Comparable to assess
    # whether this ComparableVersion's component value or the other
    # ComparableVersion's component value is greater or lesser. The first value
    # to be found as greater or lesser determines which ComparableVersion
    # object is greater or lesser.
    #
    # Missing ComparableVersion components are treated as 0 values, which
    # effectively gives them no weight in the comparison.
    #
    # @params [ComparableVersion] other the other ComparableVersion object we
    #   are comparing with
    def <=>(other)
      NAMES.each do |name|
        result = send(name).to_i <=> other.send(name).to_i
        return result unless result.zero?
      end

      0
    end

    private

    def identification
      version_identifiers =
        NAMES.map { |name|
          "#{name}:#{send(name)}" if send(name)
        }.compact.join(", ")

      "#{self.class}[#{version_identifiers}]"
    end
  end
end
