require 'test_helper'

describe VersionCompare do
  describe "#>" do
    it "returns true when left-side is greater than right-side" do
      assert { Version(2) > Version(1) }
      assert { Version(2) > Version(1.2) }
      assert { Version(2) > Version("1.2.3") }
      assert { Version(2) > Version("1.2.3.4") }

      assert { Version(2.0) > Version(1) }
      assert { Version(2.0) > Version(1.0) }
      assert { Version(2.1) > Version("2.0.3") }
      assert { Version(2.1) > Version("2.0.3.4") }

      assert { Version("2.0.0") > Version(1) }
      assert { Version("2.1.0") > Version(1.2) }
      assert { Version("2.1.0") > Version("1.2.0") }
      assert { Version("2.1.1") > Version("2.1.0.4") }

      assert { Version("2.0.0.0") > Version(1) }
      assert { Version("2.1.0.0") > Version(2.0) }
      assert { Version("2.1.1.0") > Version("2.1.0") }
      assert { Version("2.1.3.0") > Version("2.1.2.4") }

      assert { Version(2) > Version(1.99) }
      assert { Version(1.3) > Version("1.2.99") }
      assert { Version("1.2.4") > Version("1.2.3.99") }
    end

    it "returns false when left-side is less than right-side" do
      deny { Version(1) > Version(2) }
      deny { Version(1.2) > Version(2) }
      deny { Version("1.2.3") > Version(2) }
      deny { Version("1.2.3.4") > Version(2) }

      deny { Version(1) > Version(2.0) }
      deny { Version(2.0) > Version(2.1) }
      deny { Version("2.0.3") > Version(2.1) }
      deny { Version("2.0.3.4") > Version(2.1) }

      deny { Version(1) > Version("2.0.0") }
      deny { Version(1.2) > Version("2.1.0") }
      deny { Version("2.1.0") > Version("2.1.1") }
      deny { Version("2.1.0.4") > Version("2.1.1") }

      deny { Version(1) > Version("2.0.0.0") }
      deny { Version(2.0) > Version("2.1.0.0") }
      deny { Version("2.1.0") > Version("2.1.1.0") }
      deny { Version("2.1.0.4") > Version("2.1.1.0") }

      deny { Version(1.99) > Version(2) }
      deny { Version("1.2.99") > Version(1.3) }
      deny { Version("1.2.3.99") > Version("1.2.4") }
    end

    it "returns false when left-side is equal to right-side" do
      deny { Version(1) > Version(1.0) }
      deny { Version(1.2) > Version("1.2.0") }
      deny { Version("1.2.3") > Version("1.2.3.0") }
      deny { Version("1.2.3.4") > Version("1.2.3.4") }

      deny { Version(1.0) > Version(1) }
      deny { Version("1.2.0") > Version(1.2) }
      deny { Version("1.2.3") > Version("1.2.3.0") }
      deny { Version("1.2.3.4") > Version("1.2.3.4") }
    end
  end

  describe "#==" do
    it "returns false when left-side is less than right-side" do
      deny { Version(1.2) == Version(2) }
      deny { Version("1.2.3") == Version(2) }
      deny { Version("1.2.3.4") == Version(2) }

      deny { Version(1) == Version(2.0) }
      deny { Version("2.0.3") == Version(2.1) }
      deny { Version("2.0.3.4") == Version(2.1) }

      deny { Version(1) == Version("2.0.0") }
      deny { Version(1.2) == Version("2.1.0") }
      deny { Version("2.1.0.4") == Version("2.1.1") }

      deny { Version(1) == Version("2.0.0.0") }
      deny { Version(2.0) == Version("2.1.0.0") }
      deny { Version("2.1.0") == Version("2.1.1.0") }

      deny { Version(1.99) == Version(2) }
      deny { Version("1.2.99") == Version(1.3) }
      deny { Version("1.2.3.99") == Version("1.2.4") }
    end

    it "returns false when left-side is greater than right-side" do
      deny { Version(2) == Version(1.2) }
      deny { Version(2) == Version("1.2.3") }
      deny { Version(2) == Version("1.2.3.4") }

      deny { Version(2.0) == Version(1) }
      deny { Version(2.1) == Version("2.0.3") }
      deny { Version(2.1) == Version("2.0.3.4") }

      deny { Version("2.0.0") == Version(1) }
      deny { Version("2.1.0") == Version(1.2) }
      deny { Version("2.1.1") == Version("2.1.0.4") }

      deny { Version("2.0.0.0") == Version(1) }
      deny { Version("2.1.0.0") == Version(2.0) }
      deny { Version("2.1.1.0") == Version("2.1.0") }

      deny { Version(2) == Version(1.99) }
      deny { Version(1.3) == Version("1.2.99") }
      deny { Version("1.2.4") == Version("1.2.3.99") }
    end

    it "returns true when left-side is equal to right-side" do
      assert { Version(1.0) == Version(1) }
      assert { Version("1.2.0") == Version(1.2) }
      assert { Version("1.2.3.0") == Version("1.2.3") }

      assert { Version(1) == Version(1.0) }
      assert { Version(1.2) == Version("1.2.0") }
      assert { Version("1.2.3") == Version("1.2.3.0") }
    end
  end

  describe "#<" do
    it "returns true when left-side is less than right-side" do
      assert { Version(1.2) < Version(2) }
      assert { Version("1.2.3") < Version(2) }
      assert { Version("1.2.3.4") < Version(2) }

      assert { Version(1) < Version(2.0) }
      assert { Version("2.0.3") < Version(2.1) }
      assert { Version("2.0.3.4") < Version(2.1) }

      assert { Version(1) < Version("2.0.0") }
      assert { Version(1.2) < Version("2.1.0") }
      assert { Version("2.1.0.4") < Version("2.1.1") }

      assert { Version(1) < Version("2.0.0.0") }
      assert { Version(2.0) < Version("2.1.0.0") }
      assert { Version("2.1.0") < Version("2.1.1.0") }

      assert { Version(1.99) < Version(2) }
      assert { Version("1.2.99") < Version(1.3) }
      assert { Version("1.2.3.99") < Version("1.2.4") }
    end

    it "returns false when left-side is greater than right-side" do
      deny { Version(2) < Version(1.2) }
      deny { Version(2) < Version("1.2.3") }
      deny { Version(2) < Version("1.2.3.4") }

      deny { Version(2.0) < Version(1) }
      deny { Version(2.1) < Version("2.0.3") }
      deny { Version(2.1) < Version("2.0.3.4") }

      deny { Version("2.0.0") < Version(1) }
      deny { Version("2.1.0") < Version(1.2) }
      deny { Version("2.1.1") < Version("2.1.0.4") }

      deny { Version("2.0.0.0") < Version(1) }
      deny { Version("2.1.0.0") < Version(2.0) }
      deny { Version("2.1.1.0") < Version("2.1.0") }

      deny { Version(2) < Version(1.99) }
      deny { Version(1.3) < Version("1.2.99") }
      deny { Version("1.2.4") < Version("1.2.3.99") }
    end

    it "returns false when left-side is equal to right-side" do
      deny { Version(1.0) < Version(1) }
      deny { Version("1.2.0") < Version(1.2) }
      deny { Version("1.2.3.0") < Version("1.2.3") }

      deny { Version(1) < Version(1.0) }
      deny { Version(1.2) < Version("1.2.0") }
      deny { Version("1.2.3") < Version("1.2.3.0") }
    end
  end
end
