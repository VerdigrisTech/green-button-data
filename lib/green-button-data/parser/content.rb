module GreenButtonData
  module Parser
    class Content
      include SAXMachine

      element :ApplicationInformation, class: ApplicationInformation,
              as: :application_information
      element :Authorization, class: Authorization, as: :authorization
      element :IntervalBlock, class: IntervalBlock, as: :interval_block
      element :LocalTimeParameters, class: LocalTimeParameters,
              as: :local_time_parameters
      element :ReadingType, class: ReadingType, as: :reading_type
      element :UsagePoint, class: UsagePoint, as: :usage_point

      # ESPI Namespacing
      element :'espi:ApplicationInformation', class: ApplicationInformation,
              as: :application_information
      element :'espi:Authorization', class: Authorization, as: :authorization
      element :'espi:IntervalBlock', class: IntervalBlock, as: :interval_block
      element :'espi:LocalTimeParameters', class: LocalTimeParameters,
              as: :local_time_parameters
      element :'espi:ReadingType', class: ReadingType, as: :reading_type
      element :'espi:UsagePoint', class: UsagePoint, as: :usage_point

      # Special case for PG&E generic namespaces
      element :'ns0:ApplicationInformation', class: ApplicationInformation,
              as: :application_information
      element :'ns0:Authorization', class: Authorization, as: :authorization
      element :'ns0:IntervalBlock', class: IntervalBlock, as: :interval_block
      element :'ns0:LocalTimeParameters', class: LocalTimeParameters,
              as: :local_time_parameters
      element :'ns0:ReadingType', class: ReadingType, as: :reading_type
      element :'ns0:UsagePoint', class: UsagePoint, as: :usage_point
      element :'ns1:ApplicationInformation', class: ApplicationInformation,
              as: :application_information
      element :'ns1:Authorization', class: Authorization, as: :authorization
      element :'ns1:IntervalBlock', class: IntervalBlock, as: :interval_block
      element :'ns1:LocalTimeParameters', class: LocalTimeParameters,
              as: :local_time_parameters
      element :'ns1:ReadingType', class: ReadingType, as: :reading_type
      element :'ns1:UsagePoint', class: UsagePoint, as: :usage_point
    end
  end
end
