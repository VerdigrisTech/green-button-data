module Fixtures
  FIXTURES = {
    coastal_multi_family_12hr: "Coastal_Multi_Family_12hr_Jan_1_2011_to_Jan_1_2012_RetailCustomer_3.xml",
    coastal_multi_family_daily: "Coastal_Multi_Family_Daily_Jan_1_2011_to_Jan_1_2012_RetailCustomer_4.xml",
    commercial_building_1: "cc_customer_11.xml",
    commercial_building_2: "cc_customer_12.xml",
    commercial_building_3: "cc_customer_13.xml"
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
