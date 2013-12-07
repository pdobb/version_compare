require 'test_helper'

describe Conversions do
  describe "conversion function" do
    it "works on integers" do
      assert { Version(1).class == Version }
    end

    it "works on floats" do
      assert { Version(1.2).class == Version }
    end

    it "works on strings" do
      assert { Version("1.2.3.4").class == Version }
    end

    it "works on arrays" do
      assert { Version([1, 2, 3, 4]).instance_of?(Version) }
      assert { Version([1, 2, 3, 4]) == Version("1.2.3.4") }
      assert { Version(["1", "2", "3", "4"]) == Version("1.2.3.4") }
    end

    it "works on Versions" do
      assert { Version(Version(1.2)).instance_of?(Version) }
      assert { Version(Version(1.2)) == Version(1.2) }
    end
  end

  describe "explicit conversions" do
    describe "#to_s" do
      it "returns string regardless of input" do
        assert { Version(1).to_s == "1" }
        assert { Version(1.2).to_s == "1.2" }
        assert { Version("1.2.3").to_s == "1.2.3" }
      end
    end

    describe "#to_a" do
      it "returns an array of integers" do
        assert { Version(1).to_a == [1] }
        assert { Version(1.0).to_a == [1, 0] }
        assert { Version("1.2.3").to_a == [1, 2, 3] }
        assert { Version("1.2.3.4").to_a == [1, 2, 3, 4] }
        assert { Version(["1", "2", "3", "4"]).to_a == [1, 2, 3, 4] }
      end
    end
  end

  describe "implicit conversions" do
    describe "string concatination" do
      it "concatinates" do
        assert { ("version: " + Version("1.2.3.4")) == "version: 1.2.3.4" }
      end
    end

    describe "CustomObjects" do
      describe "without #to_version" do
        it "raises TypeError when attempting to convert custom objects that don't implement #to_version" do
          assert { rescuing { Version(Object.new) }.instance_of?(TypeError) }
          deny { rescuing { Version.new(Object.new) }.is_a?(StandardError) }
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

          @obj = CustomObject.new
        end

        it "returns a Version object" do
          assert { Version(@obj).instance_of?(Version) }
          assert { Version.new(@obj).instance_of?(Version) }
        end
      end
    end
  end
end
