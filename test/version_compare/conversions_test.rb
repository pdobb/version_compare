require "test_helper"

class VersionCompare::ConversionsTest < Minitest::Spec
  describe VersionCompare::Conversions do
    let(:klazz) { VersionCompare::Conversions }

    describe ".Conversion" do
      it "works on integers" do
        klazz.ComparableVersion(1).
          must_be_instance_of VersionCompare::ComparableVersion
      end

      it "works on floats" do
        klazz.ComparableVersion(1.2).
          must_be_instance_of VersionCompare::ComparableVersion
      end

      it "works on strings" do
        klazz.ComparableVersion("1.2.3.4").
          must_be_instance_of VersionCompare::ComparableVersion
      end

      it "works on arrays" do
        klazz.ComparableVersion([1, 2, 3, 4]).
          must_be_instance_of VersionCompare::ComparableVersion
        klazz.ComparableVersion([1, 2, 3, 4]).
          must_equal klazz.ComparableVersion("1.2.3.4")
        klazz.ComparableVersion(["1", "2", "3", "4"]).
          must_equal klazz.ComparableVersion("1.2.3.4")
      end

      it "works on klazz.ComparableVersions" do
        klazz.ComparableVersion(klazz.ComparableVersion(1.2)).
          must_be_instance_of VersionCompare::ComparableVersion
        klazz.ComparableVersion(klazz.ComparableVersion(1.2)).
          must_equal klazz.ComparableVersion(1.2)
      end
    end

    describe "#to_s" do
      it "returns string regardless of input" do
        klazz.ComparableVersion(1).to_s.must_equal "1"
        klazz.ComparableVersion(1.2).to_s.must_equal "1.2"
        klazz.ComparableVersion("1.2.3").to_s.must_equal "1.2.3"
      end
    end

    describe "#to_a" do
      it "returns an array of integers" do
        klazz.ComparableVersion(1).to_a.must_equal [1]
        klazz.ComparableVersion(1.0).to_a.must_equal [1, 0]
        klazz.ComparableVersion("1.2.3").to_a.must_equal [1, 2, 3]
        klazz.ComparableVersion("1.2.3.4").to_a.must_equal [1, 2, 3, 4]
        klazz.ComparableVersion(["1", "2", "3", "4"]).to_a.
          must_equal [1, 2, 3, 4]
      end
    end

    context "#+" do
      it "concatenates" do
        ("version: " + klazz.ComparableVersion("1.2.3.4")).
          must_equal "version: 1.2.3.4"
      end
    end

    context "CustomObjects" do
      context "without #to_comparable_version" do
        it "raises TypeError when attempting to convert custom objects that don't implement #to_comparable_version" do
          -> { klazz.ComparableVersion(Object.new) }.must_raise TypeError
        end
      end

      context "with #to_comparable_version" do
        before do
          class MyObject < Object
            VERSION = 1.9

            def to_comparable_version
              VersionCompare::ComparableVersion.new(VERSION.to_s)
            end
          end
        end

        subject { MyObject.new }

        it "returns a klazz.ComparableVersion object" do
          klazz.ComparableVersion(subject).
            must_be_instance_of VersionCompare::ComparableVersion
          VersionCompare::ComparableVersion.new(subject).
            must_be_instance_of VersionCompare::ComparableVersion
        end
      end
    end
  end
end
