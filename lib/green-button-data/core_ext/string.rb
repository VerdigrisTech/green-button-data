class String
  def camelize
    self.gsub(/(?<=_|^)(\w)/) { $1.upcase }
        .gsub(/(?:_)(\w)/,'\1')
  end

  def underscore
    # Shamelessly copied from Rails' ActiveSupport gem
    self.gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
        .gsub(/([a-z\d])([A-Z])/, '\1_\2')
        .tr("-", "_")
        .downcase
  end

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

  def dasherize
    self.tr('_', '-')
  end
end
