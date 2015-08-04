module Fixtures
  FIXTURES = {
    espi_application_information: "ESPIApplicationInformation.xml",
    espi_authorization: "ESPIAuthorization.xml",
    espi_interval_block: "ESPIIntervalBlock.xml",
    espi_local_time_parameters: "ESPILocalTimeParameters.xml",
    espi_reading_type: "ESPIReadingType.xml",
    espi_usage_point: "ESPIUsagePoint.xml",
    pge_application_information: "PGEApplicationInformation.xml",
    pge_authorization: "PGEAuthorization.xml",
    pge_interval_block: "PGEIntervalBlock.xml"
  }

  ##
  # Dynamically load fixtures and define them as methods
  FIXTURES.each do |method, filename|
    define_method(method) { load_fixture filename }
  end

  ##
  # Reads in the XML fixture file
  def load_fixture(filename)
    File.read "#{File.dirname __FILE__}/fixtures/#{filename}"
  end
end
