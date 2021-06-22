module ActiveRecord::Normalizations
  class TextTransformNormalizer
    VALID_TRANSFORMATIONS = [:capitalize, :word_capitalize, :uppercase, :lowercase]

    def initialize(options)
      @transformation = options[:with]

      if !VALID_TRANSFORMATIONS.include?(@transformation)
        raise ArgumentError, "#{@transformation} must be one of #{VALID_TRANSFORMATIONS}"
      end
    end

    def call(attr)
      case @transformation
      when :uppercase
        attr.upcase
      when :lowercase
        attr.downcase
      when :word_capitalize
        attr.gsub(/[[:alpha:]]+/, &:capitalize)
      else
        attr.capitalize
      end
    end
  end
end
