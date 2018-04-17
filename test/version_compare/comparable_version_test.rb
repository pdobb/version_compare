require "test_helper"

class VersionCompare::ComparableVersionTest < Minitest::Spec
  describe VersionCompare::ComparableVersion do
    let(:klazz) { VersionCompare::ComparableVersion }

    describe "#inspect" do
      it "returns expected inspect String format" do
        assert klazz.new("2.0.0").inspect
          "VersionCompare::ComparableVersion[major:2, minor:0, tiny:0]"
      end
    end

    describe "#>" do
      it "returns true when lvalue is greater than rvalue" do
        klazz.new(2).must_be :>, klazz.new(1)
        klazz.new(2).must_be :>, klazz.new(1.2)
        klazz.new(2).must_be :>, klazz.new("1.2.3")
        klazz.new(2).must_be :>, klazz.new("1.2.3.4")

        klazz.new(2.0).must_be :>, klazz.new(1)
        klazz.new(2.0).must_be :>, klazz.new(1.0)
        klazz.new(2.1).must_be :>, klazz.new("2.0.3")
        klazz.new(2.1).must_be :>, klazz.new("2.0.3.4")

        klazz.new("2.0.0").must_be :>, klazz.new(1)
        klazz.new("2.1.0").must_be :>, klazz.new(1.2)
        klazz.new("2.1.0").must_be :>, klazz.new("1.2.0")
        klazz.new("2.1.1").must_be :>, klazz.new("2.1.0.4")

        klazz.new("2.0.0.0").must_be :>, klazz.new(1)
        klazz.new("2.1.0.0").must_be :>, klazz.new(2.0)
        klazz.new("2.1.1.0").must_be :>, klazz.new("2.1.0")
        klazz.new("2.1.3.0").must_be :>, klazz.new("2.1.2.4")

        klazz.new(2).must_be :>, klazz.new(1.99)
        klazz.new(1.3).must_be :>, klazz.new("1.2.99")
        klazz.new("1.2.4").must_be :>, klazz.new("1.2.3.99")
      end

      it "returns false when lvalue is less than rvalue" do
        klazz.new(1).wont_be :>, klazz.new(2)
        klazz.new(1.2).wont_be :>, klazz.new(2)
        klazz.new("1.2.3").wont_be :>, klazz.new(2)
        klazz.new("1.2.3.4").wont_be :>, klazz.new(2)

        klazz.new(1).wont_be :>, klazz.new(2.0)
        klazz.new(2.0).wont_be :>, klazz.new(2.1)
        klazz.new("2.0.3").wont_be :>, klazz.new(2.1)
        klazz.new("2.0.3.4").wont_be :>, klazz.new(2.1)

        klazz.new(1).wont_be :>, klazz.new("2.0.0")
        klazz.new(1.2).wont_be :>, klazz.new("2.1.0")
        klazz.new("2.1.0").wont_be :>, klazz.new("2.1.1")
        klazz.new("2.1.0.4").wont_be :>, klazz.new("2.1.1")

        klazz.new(1).wont_be :>, klazz.new("2.0.0.0")
        klazz.new(2.0).wont_be :>, klazz.new("2.1.0.0")
        klazz.new("2.1.0").wont_be :>, klazz.new("2.1.1.0")
        klazz.new("2.1.0.4").wont_be :>, klazz.new("2.1.1.0")

        klazz.new(1.99).wont_be :>, klazz.new(2)
        klazz.new("1.2.99").wont_be :>, klazz.new(1.3)
        klazz.new("1.2.3.99").wont_be :>, klazz.new("1.2.4")
      end

      it "returns false when lvalue is equal to rvalue" do
        klazz.new(1).wont_be :>, klazz.new(1.0)
        klazz.new(1.2).wont_be :>, klazz.new("1.2.0")
        klazz.new("1.2.3").wont_be :>, klazz.new("1.2.3.0")
        klazz.new("1.2.3.4").wont_be :>, klazz.new("1.2.3.4")

        klazz.new(1.0).wont_be :>, klazz.new(1)
        klazz.new("1.2.0").wont_be :>, klazz.new(1.2)
        klazz.new("1.2.3").wont_be :>, klazz.new("1.2.3.0")
        klazz.new("1.2.3.4").wont_be :>, klazz.new("1.2.3.4")
      end
    end

    describe "#==" do
      it "returns false when lvalue is less than rvalue" do
        klazz.new(1.2).wont_equal klazz.new(2)
        klazz.new("1.2.3").wont_equal klazz.new(2)
        klazz.new("1.2.3.4").wont_equal klazz.new(2)

        klazz.new(1).wont_equal klazz.new(2.0)
        klazz.new("2.0.3").wont_equal klazz.new(2.1)
        klazz.new("2.0.3.4").wont_equal klazz.new(2.1)

        klazz.new(1).wont_equal klazz.new("2.0.0")
        klazz.new(1.2).wont_equal klazz.new("2.1.0")
        klazz.new("2.1.0.4").wont_equal klazz.new("2.1.1")

        klazz.new(1).wont_equal klazz.new("2.0.0.0")
        klazz.new(2.0).wont_equal klazz.new("2.1.0.0")
        klazz.new("2.1.0").wont_equal klazz.new("2.1.1.0")

        klazz.new(1.99).wont_equal klazz.new(2)
        klazz.new("1.2.99").wont_equal klazz.new(1.3)
        klazz.new("1.2.3.99").wont_equal klazz.new("1.2.4")
      end

      it "returns false when lvalue is greater than rvalue" do
        klazz.new(2).wont_equal klazz.new(1.2)
        klazz.new(2).wont_equal klazz.new("1.2.3")
        klazz.new(2).wont_equal klazz.new("1.2.3.4")

        klazz.new(2.0).wont_equal klazz.new(1)
        klazz.new(2.1).wont_equal klazz.new("2.0.3")
        klazz.new(2.1).wont_equal klazz.new("2.0.3.4")

        klazz.new("2.0.0").wont_equal klazz.new(1)
        klazz.new("2.1.0").wont_equal klazz.new(1.2)
        klazz.new("2.1.1").wont_equal klazz.new("2.1.0.4")

        klazz.new("2.0.0.0").wont_equal klazz.new(1)
        klazz.new("2.1.0.0").wont_equal klazz.new(2.0)
        klazz.new("2.1.1.0").wont_equal klazz.new("2.1.0")

        klazz.new(2).wont_equal klazz.new(1.99)
        klazz.new(1.3).wont_equal klazz.new("1.2.99")
        klazz.new("1.2.4").wont_equal klazz.new("1.2.3.99")
      end

      it "returns true when lvalue is equal to rvalue" do
        klazz.new(1.0).must_equal klazz.new(1)
        klazz.new("1.2.0").must_equal klazz.new(1.2)
        klazz.new("1.2.3.0").must_equal klazz.new("1.2.3")

        klazz.new(1).must_equal klazz.new(1.0)
        klazz.new(1.2).must_equal klazz.new("1.2.0")
        klazz.new("1.2.3").must_equal klazz.new("1.2.3.0")
      end
    end

    describe "#<" do
      it "returns true when lvalue is less than rvalue" do
        klazz.new(1.2).must_be :<, klazz.new(2)
        klazz.new("1.2.3").must_be :<, klazz.new(2)
        klazz.new("1.2.3.4").must_be :<, klazz.new(2)

        klazz.new(1).must_be :<, klazz.new(2.0)
        klazz.new("2.0.3").must_be :<, klazz.new(2.1)
        klazz.new("2.0.3.4").must_be :<, klazz.new(2.1)

        klazz.new(1).must_be :<, klazz.new("2.0.0")
        klazz.new(1.2).must_be :<, klazz.new("2.1.0")
        klazz.new("2.1.0.4").must_be :<, klazz.new("2.1.1")

        klazz.new(1).must_be :<, klazz.new("2.0.0.0")
        klazz.new(2.0).must_be :<, klazz.new("2.1.0.0")
        klazz.new("2.1.0").must_be :<, klazz.new("2.1.1.0")

        klazz.new(1.99).must_be :<, klazz.new(2)
        klazz.new("1.2.99").must_be :<, klazz.new(1.3)
        klazz.new("1.2.3.99").must_be :<, klazz.new("1.2.4")
      end

      it "returns false when lvalue is greater than rvalue" do
        klazz.new(2).wont_be :<, klazz.new(1.2)
        klazz.new(2).wont_be :<, klazz.new("1.2.3")
        klazz.new(2).wont_be :<, klazz.new("1.2.3.4")

        klazz.new(2.0).wont_be :<, klazz.new(1)
        klazz.new(2.1).wont_be :<, klazz.new("2.0.3")
        klazz.new(2.1).wont_be :<, klazz.new("2.0.3.4")

        klazz.new("2.0.0").wont_be :<, klazz.new(1)
        klazz.new("2.1.0").wont_be :<, klazz.new(1.2)
        klazz.new("2.1.1").wont_be :<, klazz.new("2.1.0.4")

        klazz.new("2.0.0.0").wont_be :<, klazz.new(1)
        klazz.new("2.1.0.0").wont_be :<, klazz.new(2.0)
        klazz.new("2.1.1.0").wont_be :<, klazz.new("2.1.0")

        klazz.new(2).wont_be :<, klazz.new(1.99)
        klazz.new(1.3).wont_be :<, klazz.new("1.2.99")
        klazz.new("1.2.4").wont_be :<, klazz.new("1.2.3.99")
      end

      it "returns false when lvalue is equal to rvalue" do
        klazz.new(1.0).wont_be :<, klazz.new(1)
        klazz.new("1.2.0").wont_be :<, klazz.new(1.2)
        klazz.new("1.2.3.0").wont_be :<, klazz.new("1.2.3")

        klazz.new(1).wont_be :<, klazz.new(1.0)
        klazz.new(1.2).wont_be :<, klazz.new("1.2.0")
        klazz.new("1.2.3").wont_be :<, klazz.new("1.2.3.0")
      end
    end
  end
end
