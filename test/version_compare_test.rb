require "test_helper"

class VersionCompareTest < Minitest::Spec
  describe VersionCompare do
    let(:klazz) { VersionCompare }

    it "has a VERSION" do
      klazz::VERSION.wont_be_nil
    end
  end
end
