require "test_helper"

module ActiveRecord::Normalizations
  class TextTransformNormalizerTest < Minitest::Test
    def setup
      @str = "jeAn-eudE"
    end

    def test_capitalize_option
      n = TextTransformNormalizer.new(with: :capitalize)
      assert_equal "Jean-eude", n.call(@str)
    end

    def test_full_capitalize_option
      n = TextTransformNormalizer.new(with: :full_capitalize)
      assert_equal "Jean-Eude", n.call(@str)
    end

    def test_lowercase_option
      n = TextTransformNormalizer.new(with: :lowercase)
      assert_equal "jean-eude", n.call(@str)
    end

    def test_uppercase_option
      n = TextTransformNormalizer.new(with: :uppercase)
      assert_equal "JEAN-EUDE", n.call(@str)
    end

    def test_invalid_option
      assert_raises(ArgumentError) do
        TextTransformNormalizer.new(with: :wrong)
      end
    end
  end
end
