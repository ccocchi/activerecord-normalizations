require "test_helper"

module ActiveRecord::Normalizations
  class SpacesNormalizerTest < Minitest::Test
    def setup
      @str = " something funny\n  "
    end

    def test_trailing_option
      n = SpacesNormalizer.new(with: :trailing)
      assert_equal " something funny", n.call(@str)
    end

    def test_leading_option
      n = SpacesNormalizer.new(with: :leading)
      assert_equal "something funny\n  ", n.call(@str)
    end

    def test_both_option
      n = SpacesNormalizer.new(with: :both)
      assert_equal "something funny", n.call(@str)
    end

    def test_with_no_option
      n = SpacesNormalizer.new({})
      assert_equal "something funny", n.call(@str)
    end

    def test_invalid_option
      assert_raises(ArgumentError) do
        SpacesNormalizer.new(with: :wrong)
      end
    end
  end
end
