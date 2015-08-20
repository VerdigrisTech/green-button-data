module GreenButtonData
  class Entry
    include Fetchable

    attr_reader :id
    attr_accessor :token

    def initialize(attributes)
      # Automagically sets instance variables from attribute hash parsed from
      # the GreenButtonData::Parser classes
      attributes.each do |key, value|
        self.instance_variable_set :"@#{key}", value
        singleton_class.class_eval do
          attr_accessor key.to_sym
        end
      end

      # Handle relations via related_urls
      @related_urls.is_a?(Hash) and @related_urls.each do |key, value|
        self.instance_variable_set :"@#{key}", value
        singleton_class.class_eval do
          attr_accessor key.to_sym
        end
      end
    end
  end
end
