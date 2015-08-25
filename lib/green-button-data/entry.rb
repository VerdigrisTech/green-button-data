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
        self.instance_variable_set :"@#{key}_url", value
        singleton_class.class_eval do
          attr_accessor "#{key}_url".to_sym
        end

        # Define accessor methods from pluralized resource names
        self.class.send :define_method, "#{key.to_s.pluralize}" do |*args|
          id = args[0]
          options = args[1]

          klazz_name = "GreenButtonData::#{key.to_s.camelize}"

          # Handle deprecations
          klazz_name.gsub! /ElectricPowerUsageSummary/, 'UsageSummary'

          klazz = klazz_name.split('::')
                            .inject(Object) { |obj, cls| obj.const_get cls }

          collection = self.instance_variable_get "@#{key.to_s.pluralize}"
          url = self.instance_variable_get "@#{key}_url"

          # Make the ID argument optional
          options ||= if id.is_a?(Hash)
            id
          else
            {}
          end

          result = if id.is_a?(Numeric) || id.is_a?(String) || id.is_a?(Symbol)
            # Try returning cached results first
            collection and instance = collection.find_by_id(id)
            cache_miss = instance.nil?

            # On cache miss, send API request
            instance ||= klazz.find "#{url}/#{id}", options

            # Cache the result
            collection ||= ModelCollection.new
            collection << instance if cache_miss

            instance
          else
            collection ||= klazz.all url, options
          end

          self.instance_variable_set :"@#{key.to_s.pluralize}", collection

          return result
        end
      end
    end
  end
end
