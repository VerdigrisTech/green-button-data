module GreenButtonData
  module Parser
    class Meter
      include SAXMachine

      element :type, as: :meter_type
      element :serialNumber, as: :meter_serial_number
      element :intervalLength, class: Integer, as: :meter_interval_length
    end
  end
end
