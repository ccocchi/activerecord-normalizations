require 'test_helper'

class User < ActiveRecord::Base
  include ActiveRecord::Normalizations
end

module ActiveRecord::Normalizations
  class ReverseNormalizer
    def initialize(*args); end
    def call(attr); attr.reverse; end
  end

  class NormalizationsTest < Minitest::Test
    def setup
      User._normalizers.clear
    end

    def test_normalize_class_method
      User.normalizes :name, spaces: true

      assert_equal 1, User._normalizers['name'].length
      assert User._normalizers['name'][0].is_a?(SpacesNormalizer)
    end

    def test_attribute_with_single_normalizer
      User.normalizes :name, spaces: true

      record = User.new(name: " Bruce Wayne")

      assert record.save
      assert_equal "Bruce Wayne", record.name

    end

    def test_attribute_with_multiple_normalizers
      User.normalizes :name, spaces: true, text_transform: :word_capitalize

      record = User.new(name: " bruce WAYNE")

      assert record.save
      assert_equal "Bruce Wayne", record.name
    end

    def test_normalization_is_run_before_validations
      User.normalizes :name, spaces: :leading
      User.validate ->(u) { errors.add(:name, "is wrong") if u.name.start_with?(' ') }

      record = User.new(name: " Bruce")

      assert record.valid?
      assert_equal "Bruce", record.name
    end

    def test_normalization_is_used_when_validation_is_skipped
      User.normalizes :name, spaces: true

      record = User.new(name: " Bruce")

      assert record.save(validate: false)
      assert_equal "Bruce", record.name
    end

    def test_normalization_is_applied_during_updates
      User.normalizes :name, spaces: true

      record = User.new

      assert record.update(name: " Bruce")
      assert_equal "Bruce", record.name
    end

    def test_custom_normalizer
      User.normalizes :name, reverse: true
      record = User.new(name: "Bruce")

      assert record.save
      assert_equal "ecurB", record.name
    end
  end
end
