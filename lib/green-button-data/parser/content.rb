module GreenButtonData
  module Parser
    class Content
      include SAXMachine

      element :ApplicationInformation, class: ApplicationInformation,
              as: :application_information
      element :Authorization, class: Authorization, as: :authorization
      element :ElectricPowerUsageSummary, class: UsageSummary,
              as: :electric_power_usage_summary do |electric_power_usage_summary|
        warn "[DEPRECATED] ElectricPowerUsageSummary element is deprecated by OpenESPI Green Button Data standards. Please migrate to UsageSummary in the future."
        electric_power_usage_summary
      end
      element :IntervalBlock, class: IntervalBlock, as: :interval_block
      element :LocalTimeParameters, class: LocalTimeParameters,
              as: :local_time_parameters
      element :ReadingType, class: ReadingType, as: :reading_type
      element :UsagePoint, class: UsagePoint, as: :usage_point
      element :UsageSummary, class: UsageSummary, as: :usage_summary

      # ESPI Namespacing
      element :'espi:ApplicationInformation', class: ApplicationInformation,
              as: :application_information
      element :'espi:Authorization', class: Authorization, as: :authorization
      element :'espi:ElectricPowerUsageSummary', class: UsageSummary,
              as: :electric_power_usage_summary do |electric_power_usage_summary|
        warn "[DEPRECATED] ElectricPowerUsageSummary element is deprecated by OpenESPI Green Button Data standards. Please migrate to UsageSummary in the future."
        electric_power_usage_summary
      end
      element :'espi:IntervalBlock', class: IntervalBlock, as: :interval_block
      element :'espi:LocalTimeParameters', class: LocalTimeParameters,
              as: :local_time_parameters
      element :'espi:ReadingType', class: ReadingType, as: :reading_type
      element :'espi:UsagePoint', class: UsagePoint, as: :usage_point
      element :'espi:UsageSummary', class: UsageSummary, as: :usage_summary

      # Special case for PG&E generic namespaces
      element :'ns0:ApplicationInformation', class: ApplicationInformation,
              as: :application_information
      element :'ns0:Authorization', class: Authorization, as: :authorization
      element :'ns0:IntervalBlock', class: IntervalBlock, as: :interval_block
      element :'ns0:LocalTimeParameters', class: LocalTimeParameters,
              as: :local_time_parameters
      element :'ns0:ReadingType', class: ReadingType, as: :reading_type
      element :'ns0:UsagePoint', class: UsagePoint, as: :usage_point
      element :'ns0:UsageSummary', class: UsageSummary, as: :usage_summary
    end
  end
end
