String.class_eval do
  unless String.new.respond_to? :camelize
    def camelize
      self.gsub(/(?<=_|^)(\w)/) { $1.upcase }
          .gsub(/(?:_)(\w)/,'\1')
    end
  end

  unless String.new.respond_to? :underscore
    def underscore
      # Shamelessly copied from Rails' ActiveSupport gem
      self.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr("-", "_")
          .downcase
    end
  end

  unless String.new.respond_to? :pluralize
    def pluralize
      result = self.dup

      if self.empty?
        return result
      else
        [
          [/([^aeiouy]|qu)y$/i, '\1ies'],
          [/s$/i, 's'],
          [/$/, 's']
        ].each { |(rule, replacement)| break if result.sub!(rule, replacement) }

        return result
      end
    end
  end

  unless String.new.respond_to? :dasherize
    def dasherize
      self.tr('_', '-')
    end
  end
end # String.class_eval
