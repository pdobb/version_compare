require 'test_helper'

describe Conversions do
  describe "conversion function" do
    it "works on integers" do
      Version(1).class.must_equal Version
    end

    it "works on floats" do
      Version(1.2).class.must_equal Version
    end

    it "works on strings" do
      Version("1.2.3.4").class.must_equal Version
    end

    it "works on arrays" do
      Version([1, 2, 3, 4]).must_be_instance_of Version
      Version([1, 2, 3, 4]).must_equal Version("1.2.3.4")
      Version(["1", "2", "3", "4"]).must_equal Version("1.2.3.4")
    end

    it "works on Versions" do
      Version(Version(1.2)).must_be_instance_of Version
      Version(Version(1.2)).must_equal Version(1.2)
    end
  end

  describe "explicit conversions" do
    describe "#to_s" do
      it "returns string regardless of input" do
        Version(1).to_s.must_equal "1"
        Version(1.2).to_s.must_equal "1.2"
        Version("1.2.3").to_s.must_equal "1.2.3"
      end
    end

    describe "#to_a" do
      it "returns an array of integers" do
        Version(1).to_a.must_equal [1]
        Version(1.0).to_a.must_equal [1, 0]
        Version("1.2.3").to_a.must_equal [1, 2, 3]
        Version("1.2.3.4").to_a.must_equal [1, 2, 3, 4]
        Version(["1", "2", "3", "4"]).to_a.must_equal [1, 2, 3, 4]
      end
    end
  end

  describe "implicit conversions" do
    describe "string concatenation" do
      it "concatenates" do
        ("version: " + Version("1.2.3.4")).must_equal "version: 1.2.3.4"
      end
    end

    describe "CustomObjects" do
      describe "without #to_version" do
        it "raises TypeError when attempting to convert custom objects that don't implement #to_version" do
          -> { Version(Object.new) }.must_raise TypeError
        end
      end

      describe "with #to_version" do
        before do
          class CustomObject < Object
            VERSION = 1.9
            def to_version
              Version.new(VERSION.to_s)
            end
          end
        end

        subject { CustomObject.new }

        it "returns a Version object" do
          Version(subject).must_be_instance_of Version
          Version.new(subject).must_be_instance_of Version
        end
      end
    end
  end
end
