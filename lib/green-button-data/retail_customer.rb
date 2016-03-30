module GreenButtonData
  class RetailCustomer < Entry
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
      {
        customer_agreement_id: customer_agreement_id,
        service_uuid: service_uuid
      }
    end

    private

    def service_uuid
      @id
    end

    def customer_agreement_id
      @customer_agreement_id
    end

    def present?(data)
      !blank?(data)
    end

    def blank?(data)
      data.respond_to?(:empty?) ? !!data.empty? : !data
    end
  end
end
