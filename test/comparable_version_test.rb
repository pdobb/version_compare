require 'test_helper'

describe ComparableVersion do
  describe "#>" do
    it "returns true when lvalue is greater than rvalue" do
      ComparableVersion(2).must_be :>, ComparableVersion(1)
      ComparableVersion(2).must_be :>, ComparableVersion(1.2)
      ComparableVersion(2).must_be :>, ComparableVersion("1.2.3")
      ComparableVersion(2).must_be :>, ComparableVersion("1.2.3.4")

      ComparableVersion(2.0).must_be :>, ComparableVersion(1)
      ComparableVersion(2.0).must_be :>, ComparableVersion(1.0)
      ComparableVersion(2.1).must_be :>, ComparableVersion("2.0.3")
      ComparableVersion(2.1).must_be :>, ComparableVersion("2.0.3.4")

      ComparableVersion("2.0.0").must_be :>, ComparableVersion(1)
      ComparableVersion("2.1.0").must_be :>, ComparableVersion(1.2)
      ComparableVersion("2.1.0").must_be :>, ComparableVersion("1.2.0")
      ComparableVersion("2.1.1").must_be :>, ComparableVersion("2.1.0.4")

      ComparableVersion("2.0.0.0").must_be :>, ComparableVersion(1)
      ComparableVersion("2.1.0.0").must_be :>, ComparableVersion(2.0)
      ComparableVersion("2.1.1.0").must_be :>, ComparableVersion("2.1.0")
      ComparableVersion("2.1.3.0").must_be :>, ComparableVersion("2.1.2.4")

      ComparableVersion(2).must_be :>, ComparableVersion(1.99)
      ComparableVersion(1.3).must_be :>, ComparableVersion("1.2.99")
      ComparableVersion("1.2.4").must_be :>, ComparableVersion("1.2.3.99")
    end

    it "returns false when lvalue is less than rvalue" do
      ComparableVersion(1).wont_be :>, ComparableVersion(2)
      ComparableVersion(1.2).wont_be :>, ComparableVersion(2)
      ComparableVersion("1.2.3").wont_be :>, ComparableVersion(2)
      ComparableVersion("1.2.3.4").wont_be :>, ComparableVersion(2)

      ComparableVersion(1).wont_be :>, ComparableVersion(2.0)
      ComparableVersion(2.0).wont_be :>, ComparableVersion(2.1)
      ComparableVersion("2.0.3").wont_be :>, ComparableVersion(2.1)
      ComparableVersion("2.0.3.4").wont_be :>, ComparableVersion(2.1)

      ComparableVersion(1).wont_be :>, ComparableVersion("2.0.0")
      ComparableVersion(1.2).wont_be :>, ComparableVersion("2.1.0")
      ComparableVersion("2.1.0").wont_be :>, ComparableVersion("2.1.1")
      ComparableVersion("2.1.0.4").wont_be :>, ComparableVersion("2.1.1")

      ComparableVersion(1).wont_be :>, ComparableVersion("2.0.0.0")
      ComparableVersion(2.0).wont_be :>, ComparableVersion("2.1.0.0")
      ComparableVersion("2.1.0").wont_be :>, ComparableVersion("2.1.1.0")
      ComparableVersion("2.1.0.4").wont_be :>, ComparableVersion("2.1.1.0")

      ComparableVersion(1.99).wont_be :>, ComparableVersion(2)
      ComparableVersion("1.2.99").wont_be :>, ComparableVersion(1.3)
      ComparableVersion("1.2.3.99").wont_be :>, ComparableVersion("1.2.4")
    end

    it "returns false when lvalue is equal to rvalue" do
      ComparableVersion(1).wont_be :>, ComparableVersion(1.0)
      ComparableVersion(1.2).wont_be :>, ComparableVersion("1.2.0")
      ComparableVersion("1.2.3").wont_be :>, ComparableVersion("1.2.3.0")
      ComparableVersion("1.2.3.4").wont_be :>, ComparableVersion("1.2.3.4")

      ComparableVersion(1.0).wont_be :>, ComparableVersion(1)
      ComparableVersion("1.2.0").wont_be :>, ComparableVersion(1.2)
      ComparableVersion("1.2.3").wont_be :>, ComparableVersion("1.2.3.0")
      ComparableVersion("1.2.3.4").wont_be :>, ComparableVersion("1.2.3.4")
    end
  end

  describe "#==" do
    it "returns false when lvalue is less than rvalue" do
      ComparableVersion(1.2).wont_equal ComparableVersion(2)
      ComparableVersion("1.2.3").wont_equal ComparableVersion(2)
      ComparableVersion("1.2.3.4").wont_equal ComparableVersion(2)

      ComparableVersion(1).wont_equal ComparableVersion(2.0)
      ComparableVersion("2.0.3").wont_equal ComparableVersion(2.1)
      ComparableVersion("2.0.3.4").wont_equal ComparableVersion(2.1)

      ComparableVersion(1).wont_equal ComparableVersion("2.0.0")
      ComparableVersion(1.2).wont_equal ComparableVersion("2.1.0")
      ComparableVersion("2.1.0.4").wont_equal ComparableVersion("2.1.1")

      ComparableVersion(1).wont_equal ComparableVersion("2.0.0.0")
      ComparableVersion(2.0).wont_equal ComparableVersion("2.1.0.0")
      ComparableVersion("2.1.0").wont_equal ComparableVersion("2.1.1.0")

      ComparableVersion(1.99).wont_equal ComparableVersion(2)
      ComparableVersion("1.2.99").wont_equal ComparableVersion(1.3)
      ComparableVersion("1.2.3.99").wont_equal ComparableVersion("1.2.4")
    end

    it "returns false when lvalue is greater than rvalue" do
      ComparableVersion(2).wont_equal ComparableVersion(1.2)
      ComparableVersion(2).wont_equal ComparableVersion("1.2.3")
      ComparableVersion(2).wont_equal ComparableVersion("1.2.3.4")

      ComparableVersion(2.0).wont_equal ComparableVersion(1)
      ComparableVersion(2.1).wont_equal ComparableVersion("2.0.3")
      ComparableVersion(2.1).wont_equal ComparableVersion("2.0.3.4")

      ComparableVersion("2.0.0").wont_equal ComparableVersion(1)
      ComparableVersion("2.1.0").wont_equal ComparableVersion(1.2)
      ComparableVersion("2.1.1").wont_equal ComparableVersion("2.1.0.4")

      ComparableVersion("2.0.0.0").wont_equal ComparableVersion(1)
      ComparableVersion("2.1.0.0").wont_equal ComparableVersion(2.0)
      ComparableVersion("2.1.1.0").wont_equal ComparableVersion("2.1.0")

      ComparableVersion(2).wont_equal ComparableVersion(1.99)
      ComparableVersion(1.3).wont_equal ComparableVersion("1.2.99")
      ComparableVersion("1.2.4").wont_equal ComparableVersion("1.2.3.99")
    end

    it "returns true when lvalue is equal to rvalue" do
      ComparableVersion(1.0).must_equal ComparableVersion(1)
      ComparableVersion("1.2.0").must_equal ComparableVersion(1.2)
      ComparableVersion("1.2.3.0").must_equal ComparableVersion("1.2.3")

      ComparableVersion(1).must_equal ComparableVersion(1.0)
      ComparableVersion(1.2).must_equal ComparableVersion("1.2.0")
      ComparableVersion("1.2.3").must_equal ComparableVersion("1.2.3.0")
    end
  end

  describe "#<" do
    it "returns true when lvalue is less than rvalue" do
      ComparableVersion(1.2).must_be :<, ComparableVersion(2)
      ComparableVersion("1.2.3").must_be :<, ComparableVersion(2)
      ComparableVersion("1.2.3.4").must_be :<, ComparableVersion(2)

      ComparableVersion(1).must_be :<, ComparableVersion(2.0)
      ComparableVersion("2.0.3").must_be :<, ComparableVersion(2.1)
      ComparableVersion("2.0.3.4").must_be :<, ComparableVersion(2.1)

      ComparableVersion(1).must_be :<, ComparableVersion("2.0.0")
      ComparableVersion(1.2).must_be :<, ComparableVersion("2.1.0")
      ComparableVersion("2.1.0.4").must_be :<, ComparableVersion("2.1.1")

      ComparableVersion(1).must_be :<, ComparableVersion("2.0.0.0")
      ComparableVersion(2.0).must_be :<, ComparableVersion("2.1.0.0")
      ComparableVersion("2.1.0").must_be :<, ComparableVersion("2.1.1.0")

      ComparableVersion(1.99).must_be :<, ComparableVersion(2)
      ComparableVersion("1.2.99").must_be :<, ComparableVersion(1.3)
      ComparableVersion("1.2.3.99").must_be :<, ComparableVersion("1.2.4")
    end

    it "returns false when lvalue is greater than rvalue" do
      ComparableVersion(2).wont_be :<, ComparableVersion(1.2)
      ComparableVersion(2).wont_be :<, ComparableVersion("1.2.3")
      ComparableVersion(2).wont_be :<, ComparableVersion("1.2.3.4")

      ComparableVersion(2.0).wont_be :<, ComparableVersion(1)
      ComparableVersion(2.1).wont_be :<, ComparableVersion("2.0.3")
      ComparableVersion(2.1).wont_be :<, ComparableVersion("2.0.3.4")

      ComparableVersion("2.0.0").wont_be :<, ComparableVersion(1)
      ComparableVersion("2.1.0").wont_be :<, ComparableVersion(1.2)
      ComparableVersion("2.1.1").wont_be :<, ComparableVersion("2.1.0.4")

      ComparableVersion("2.0.0.0").wont_be :<, ComparableVersion(1)
      ComparableVersion("2.1.0.0").wont_be :<, ComparableVersion(2.0)
      ComparableVersion("2.1.1.0").wont_be :<, ComparableVersion("2.1.0")

      ComparableVersion(2).wont_be :<, ComparableVersion(1.99)
      ComparableVersion(1.3).wont_be :<, ComparableVersion("1.2.99")
      ComparableVersion("1.2.4").wont_be :<, ComparableVersion("1.2.3.99")
    end

    it "returns false when lvalue is equal to rvalue" do
      ComparableVersion(1.0).wont_be :<, ComparableVersion(1)
      ComparableVersion("1.2.0").wont_be :<, ComparableVersion(1.2)
      ComparableVersion("1.2.3.0").wont_be :<, ComparableVersion("1.2.3")

      ComparableVersion(1).wont_be :<, ComparableVersion(1.0)
      ComparableVersion(1.2).wont_be :<, ComparableVersion("1.2.0")
      ComparableVersion("1.2.3").wont_be :<, ComparableVersion("1.2.3.0")
    end
  end
end
