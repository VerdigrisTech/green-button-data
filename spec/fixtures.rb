module Fixtures
  FIXTURES = {
    espi_application_information: "ESPIApplicationInformation.xml",
    espi_authorization: "ESPIAuthorization.xml"
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
