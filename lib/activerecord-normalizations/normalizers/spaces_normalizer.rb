module ActiveRecord::Normalizations
  class SpacesNormalizer
    VALID_TYPES = [:leading, :trailing, :both]

    def initialize(options)
      type = options[:with] || :both
      raise ArgumentError, "#{type} must be one of #{VALID_TYPES}" if !VALID_TYPES.include?(type)

      @method = determine_method(type)
    end

    def call(attr)
      attr.send(@method)
    end

    private

    def determine_method(type)
      case type
      when :leading
        :lstrip
      when :trailing
        :rstrip
      else
        :strip
      end
    end
  end
end
