module GreenButtonData
  class Configuration
    attr_accessor :base_url,
                  :application_information_path,
                  :authorization_path,
                  :interval_block_path,
                  :meter_reading_path,
                  :reading_type_path,
                  :usage_point_path,
                  :usage_summary_path
  end
end
