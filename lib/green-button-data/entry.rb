module GreenButtonData
  class Entry
    include Fetchable

    attr_reader :id

    def initialize(attributes)
      attributes.each do |key, value|
        self.instance_variable_set :"@#{key}", value
        singleton_class.class_eval do
          attr_accessor key.to_sym
        end
      end

      @related_urls.is_a?(Hash) and @related_urls.each do |key, value|
        self.instance_variable_set :"@#{key}", value
        singleton_class.class_eval do
          attr_accessor key.to_sym
        end
      end
    end
  end
end
