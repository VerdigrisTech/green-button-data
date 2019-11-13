module GreenButtonData
  class RetailCustomer < Entry
    attr_reader :account_id,
                :customer_agreement_id,
                :links,
                :meter_interval_length,
                :meter_serial_number,
                :meter_type,
                :name

    def has_address?
      present?(address_general)
    end

    def has_agreement_id_map?
      present?(customer_agreement_id)
    end

    def address_general
      @main_address.to_s
    end

    def agreement_id_service_uuid_map
      result = {}

      if has_agreement_id_map?
        result[:customer_agreement_id] = customer_agreement_id
        result[:service_uuid] = service_uuid
      end

      result
    end

    private

    def service_uuid
      @id
    end

    def present?(data)
      !blank?(data)
    end

    def blank?(data)
      data.respond_to?(:empty?) ? !!data.empty? : !data
    end
  end
end
