module GreenButtonData
  class Entry
    include Fetchable
    include Utilities

    attr_reader :id
    attr_accessor :token

    def initialize(attributes)
      # Automagically sets instance variables from attribute hash parsed from
      # the GreenButtonData::Parser classes
      init_instance_vars attributes

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

          # Make the ID argument optional
          options ||= if id.is_a?(Hash)
            id
          else
            {}
          end

          if id.is_a?(Numeric) || id.is_a?(String) || id.is_a?(Symbol)
            get_or_fetch_entry id, key, options
          else
            get_or_fetch_collection key, options
          end
        end
      end
    end # initialize

    protected

    def get_enum_symbol(enum, value)
      if value.is_a? Numeric
        enum[value]
      else
        value
      end
    end

    private

    def init_instance_vars(attributes)
      attributes.each do |key, value|
        self.instance_variable_set :"@#{key}", value
      end
    end

    def klazz_name(name)
      str = "GreenButtonData::#{name}"
      str.gsub! /ElectricPowerUsageSummary/, 'UsageSummary'
      return str
    end

    def get_or_fetch_collection(key, options = {})
      klazz = class_from_name klazz_name(key.to_s.camelize)
      url = self.instance_variable_get "@#{key}_url"
      collection = self.instance_variable_get "@#{key.to_s.pluralize}"

      collection = if !options[:reload] && collection
        collection
      else
        collection = klazz.all url, options
      end

      self.instance_variable_set :"@#{key.to_s.pluralize}", collection

      return collection
    end

    def get_or_fetch_entry(id, key, options = {})
      klazz = class_from_name klazz_name(key.to_s.camelize)
      url = self.instance_variable_get "@#{key}_url"
      collection = self.instance_variable_get "@#{key.to_s.pluralize}"

      # Try returning cached results first
      collection and instance = collection.find_by_id(id)
      cache_miss = instance.nil?

      # On cache miss or forced reload, send API request
      instance = if !options[:reload] && instance
        instance
      else
        klazz.find "#{url}/#{id}", options
      end

      # Cache the result
      collection ||= ModelCollection.new
      collection << instance if cache_miss

      self.instance_variable_set :"@#{key.to_s.pluralize}", collection

      instance
    end
  end # Entry
end # GreenButtonData
