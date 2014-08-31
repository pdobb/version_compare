require 'test_helper'

describe VersionCompare do
  describe "#>" do
    it "returns true when lvalue is greater than rvalue" do
      Version(2).must_be :>, Version(1)
      Version(2).must_be :>, Version(1.2)
      Version(2).must_be :>, Version("1.2.3")
      Version(2).must_be :>, Version("1.2.3.4")

      Version(2.0).must_be :>, Version(1)
      Version(2.0).must_be :>, Version(1.0)
      Version(2.1).must_be :>, Version("2.0.3")
      Version(2.1).must_be :>, Version("2.0.3.4")

      Version("2.0.0").must_be :>, Version(1)
      Version("2.1.0").must_be :>, Version(1.2)
      Version("2.1.0").must_be :>, Version("1.2.0")
      Version("2.1.1").must_be :>, Version("2.1.0.4")

      Version("2.0.0.0").must_be :>, Version(1)
      Version("2.1.0.0").must_be :>, Version(2.0)
      Version("2.1.1.0").must_be :>, Version("2.1.0")
      Version("2.1.3.0").must_be :>, Version("2.1.2.4")

      Version(2).must_be :>, Version(1.99)
      Version(1.3).must_be :>, Version("1.2.99")
      Version("1.2.4").must_be :>, Version("1.2.3.99")
    end

    it "returns false when lvalue is less than rvalue" do
      Version(1).wont_be :>, Version(2)
      Version(1.2).wont_be :>, Version(2)
      Version("1.2.3").wont_be :>, Version(2)
      Version("1.2.3.4").wont_be :>, Version(2)

      Version(1).wont_be :>, Version(2.0)
      Version(2.0).wont_be :>, Version(2.1)
      Version("2.0.3").wont_be :>, Version(2.1)
      Version("2.0.3.4").wont_be :>, Version(2.1)

      Version(1).wont_be :>, Version("2.0.0")
      Version(1.2).wont_be :>, Version("2.1.0")
      Version("2.1.0").wont_be :>, Version("2.1.1")
      Version("2.1.0.4").wont_be :>, Version("2.1.1")

      Version(1).wont_be :>, Version("2.0.0.0")
      Version(2.0).wont_be :>, Version("2.1.0.0")
      Version("2.1.0").wont_be :>, Version("2.1.1.0")
      Version("2.1.0.4").wont_be :>, Version("2.1.1.0")

      Version(1.99).wont_be :>, Version(2)
      Version("1.2.99").wont_be :>, Version(1.3)
      Version("1.2.3.99").wont_be :>, Version("1.2.4")
    end

    it "returns false when lvalue is equal to rvalue" do
      Version(1).wont_be :>, Version(1.0)
      Version(1.2).wont_be :>, Version("1.2.0")
      Version("1.2.3").wont_be :>, Version("1.2.3.0")
      Version("1.2.3.4").wont_be :>, Version("1.2.3.4")

      Version(1.0).wont_be :>, Version(1)
      Version("1.2.0").wont_be :>, Version(1.2)
      Version("1.2.3").wont_be :>, Version("1.2.3.0")
      Version("1.2.3.4").wont_be :>, Version("1.2.3.4")
    end
  end

  describe "#==" do
    it "returns false when lvalue is less than rvalue" do
      Version(1.2).wont_equal Version(2)
      Version("1.2.3").wont_equal Version(2)
      Version("1.2.3.4").wont_equal Version(2)

      Version(1).wont_equal Version(2.0)
      Version("2.0.3").wont_equal Version(2.1)
      Version("2.0.3.4").wont_equal Version(2.1)

      Version(1).wont_equal Version("2.0.0")
      Version(1.2).wont_equal Version("2.1.0")
      Version("2.1.0.4").wont_equal Version("2.1.1")

      Version(1).wont_equal Version("2.0.0.0")
      Version(2.0).wont_equal Version("2.1.0.0")
      Version("2.1.0").wont_equal Version("2.1.1.0")

      Version(1.99).wont_equal Version(2)
      Version("1.2.99").wont_equal Version(1.3)
      Version("1.2.3.99").wont_equal Version("1.2.4")
    end

    it "returns false when lvalue is greater than rvalue" do
      Version(2).wont_equal Version(1.2)
      Version(2).wont_equal Version("1.2.3")
      Version(2).wont_equal Version("1.2.3.4")

      Version(2.0).wont_equal Version(1)
      Version(2.1).wont_equal Version("2.0.3")
      Version(2.1).wont_equal Version("2.0.3.4")

      Version("2.0.0").wont_equal Version(1)
      Version("2.1.0").wont_equal Version(1.2)
      Version("2.1.1").wont_equal Version("2.1.0.4")

      Version("2.0.0.0").wont_equal Version(1)
      Version("2.1.0.0").wont_equal Version(2.0)
      Version("2.1.1.0").wont_equal Version("2.1.0")

      Version(2).wont_equal Version(1.99)
      Version(1.3).wont_equal Version("1.2.99")
      Version("1.2.4").wont_equal Version("1.2.3.99")
    end

    it "returns true when lvalue is equal to rvalue" do
      Version(1.0).must_equal Version(1)
      Version("1.2.0").must_equal Version(1.2)
      Version("1.2.3.0").must_equal Version("1.2.3")

      Version(1).must_equal Version(1.0)
      Version(1.2).must_equal Version("1.2.0")
      Version("1.2.3").must_equal Version("1.2.3.0")
    end
  end

  describe "#<" do
    it "returns true when lvalue is less than rvalue" do
      Version(1.2).must_be :<, Version(2)
      Version("1.2.3").must_be :<, Version(2)
      Version("1.2.3.4").must_be :<, Version(2)

      Version(1).must_be :<, Version(2.0)
      Version("2.0.3").must_be :<, Version(2.1)
      Version("2.0.3.4").must_be :<, Version(2.1)

      Version(1).must_be :<, Version("2.0.0")
      Version(1.2).must_be :<, Version("2.1.0")
      Version("2.1.0.4").must_be :<, Version("2.1.1")

      Version(1).must_be :<, Version("2.0.0.0")
      Version(2.0).must_be :<, Version("2.1.0.0")
      Version("2.1.0").must_be :<, Version("2.1.1.0")

      Version(1.99).must_be :<, Version(2)
      Version("1.2.99").must_be :<, Version(1.3)
      Version("1.2.3.99").must_be :<, Version("1.2.4")
    end

    it "returns false when lvalue is greater than rvalue" do
      Version(2).wont_be :<, Version(1.2)
      Version(2).wont_be :<, Version("1.2.3")
      Version(2).wont_be :<, Version("1.2.3.4")

      Version(2.0).wont_be :<, Version(1)
      Version(2.1).wont_be :<, Version("2.0.3")
      Version(2.1).wont_be :<, Version("2.0.3.4")

      Version("2.0.0").wont_be :<, Version(1)
      Version("2.1.0").wont_be :<, Version(1.2)
      Version("2.1.1").wont_be :<, Version("2.1.0.4")

      Version("2.0.0.0").wont_be :<, Version(1)
      Version("2.1.0.0").wont_be :<, Version(2.0)
      Version("2.1.1.0").wont_be :<, Version("2.1.0")

      Version(2).wont_be :<, Version(1.99)
      Version(1.3).wont_be :<, Version("1.2.99")
      Version("1.2.4").wont_be :<, Version("1.2.3.99")
    end

    it "returns false when lvalue is equal to rvalue" do
      Version(1.0).wont_be :<, Version(1)
      Version("1.2.0").wont_be :<, Version(1.2)
      Version("1.2.3.0").wont_be :<, Version("1.2.3")

      Version(1).wont_be :<, Version(1.0)
      Version(1.2).wont_be :<, Version("1.2.0")
      Version("1.2.3").wont_be :<, Version("1.2.3.0")
    end
  end
end
