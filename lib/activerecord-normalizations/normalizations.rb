require 'active_support/concern'

module ActiveRecord::Normalizations
  extend ActiveSupport::Concern

  included do
    class_attribute :_normalizers, instance_writer: false, default: Hash.new { |h, k| h[k] = [] }
  end

  SHARED_OPTIONS  = [:on, :if, :unless].freeze
  DEFAULT_OPTIONS = {}.freeze

  module ClassMethods
    #
    #   normalize :firstname, spaces: true, text_transform: :capitalize
    #
    def normalizes(attr, **normalizations)
      attr_str = attr.to_s

      normalizations.each do |key, options|
        next unless options

        key = "#{key.to_s.camelize}Normalizer"

        begin
          klass = key.include?("::") ? key.constantize : const_get(key)
        rescue NameError
          raise ArgumentError, "Unknown validator: '#{key}'"
        end

        normalizer = klass.new(_parse_normalizer_options(options))
        _normalizers[attr_str] << normalizer
      end
    end

    # Avoid sharing normalizers between subclasses
    def inherited(base) # :nodoc:
      base._normalizers = _normalizers.dup
      super
    end

    private

    def _parse_normalizer_options(opts)
      case opts
      when TrueClass
        DEFAULT_OPTIONS
      when Hash
        opts
      when String, Symbol
        { with: opts }
      else
        raise
      end
    end
  end

  def save(**options)
    _perform_normalizations(options) if options[:validate] == false
    super
  end

  def save!(**options)
    _perform_normalizations(options) if options[:validate] == false
    super
  end

  def valid?(*args)
    _perform_normalizations(DEFAULT_OPTIONS)
    super
  end

  private

  def _perform_normalizations(options)
    return if options[:normalize] == false

    _normalizers.each do |attr, norms|
      value = self[attr]

      if value.present? && will_save_change_to_attribute?(attr)
        self[attr] = norms.reduce(value) { |res, n| n.call(res) }
      end
    end
  end
end

require "activerecord-normalizations/normalizers/spaces_normalizer"
require "activerecord-normalizations/normalizers/text_transform_normalizer"
