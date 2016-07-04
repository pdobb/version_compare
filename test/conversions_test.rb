require 'test_helper'

describe Conversions do
  describe "conversion function" do
    it "works on integers" do
      ComparableVersion(1).class.must_equal ComparableVersion
    end

    it "works on floats" do
      ComparableVersion(1.2).class.must_equal ComparableVersion
    end

    it "works on strings" do
      ComparableVersion("1.2.3.4").class.must_equal ComparableVersion
    end

    it "works on arrays" do
      ComparableVersion([1, 2, 3, 4]).must_be_instance_of ComparableVersion
      ComparableVersion([1, 2, 3, 4]).must_equal ComparableVersion("1.2.3.4")
      ComparableVersion(["1", "2", "3", "4"]).must_equal ComparableVersion("1.2.3.4")
    end

    it "works on ComparableVersions" do
      ComparableVersion(ComparableVersion(1.2)).must_be_instance_of ComparableVersion
      ComparableVersion(ComparableVersion(1.2)).must_equal ComparableVersion(1.2)
    end
  end

  describe "explicit conversions" do
    describe "#to_s" do
      it "returns string regardless of input" do
        ComparableVersion(1).to_s.must_equal "1"
        ComparableVersion(1.2).to_s.must_equal "1.2"
        ComparableVersion("1.2.3").to_s.must_equal "1.2.3"
      end
    end

    describe "#to_a" do
      it "returns an array of integers" do
        ComparableVersion(1).to_a.must_equal [1]
        ComparableVersion(1.0).to_a.must_equal [1, 0]
        ComparableVersion("1.2.3").to_a.must_equal [1, 2, 3]
        ComparableVersion("1.2.3.4").to_a.must_equal [1, 2, 3, 4]
        ComparableVersion(["1", "2", "3", "4"]).to_a.must_equal [1, 2, 3, 4]
      end
    end
  end

  describe "implicit conversions" do
    describe "string concatenation" do
      it "concatenates" do
        ("version: " + ComparableVersion("1.2.3.4")).must_equal "version: 1.2.3.4"
      end
    end

    describe "CustomObjects" do
      describe "without #to_comparable_version" do
        it "raises TypeError when attempting to convert custom objects that don't implement #to_comparable_version" do
          -> { ComparableVersion(Object.new) }.must_raise TypeError
        end
      end

      describe "with #to_comparable_version" do
        before do
          class CustomObject < Object
            VERSION = 1.9
            def to_comparable_version
              ComparableVersion.new(VERSION.to_s)
            end
          end
        end

        subject { CustomObject.new }

        it "returns a ComparableVersion object" do
          ComparableVersion(subject).must_be_instance_of ComparableVersion
          ComparableVersion.new(subject).must_be_instance_of ComparableVersion
        end
      end
    end
  end
end
