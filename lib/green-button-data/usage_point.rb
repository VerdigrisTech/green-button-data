module GreenButtonData
  class UsagePoint < Entry
    include Enumerations

    attr_accessor :service_category

    def initialize(attributes)
      super

      # If deprecated usage summary name is used, create an alias
      if self.class.instance_methods.grep(/electric_power_usage/).size > 0
        warn "DEPRECATED: ElectricPowerUsageSummary has been renamed to UsageSummary"
        singleton_class.class_eval do
          alias_method :usage_summaries, :electric_power_usage_summaries
        end
      end
    end

    def service_category
      SERVICE[@kind]
    end

    def usage_summary_url
      return @usage_summary_url || @electric_power_usage_summary_url
    end
  end
end
