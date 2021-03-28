module GreenButtonData
  module Parser
    class CustomerAgreement
      include SAXMachine

      element :name, as: :customer_agreement_id
      element :type
      element :docStatus, class: DocStatus, as: :doc_status
      element :signDate, class: Integer, as: :sign_date

      # ESPI Namespacing
      element :'espi:name', as: :customer_agreement_id

      # Special case for PG&E generic namespacing
      element :'ns0:name', as: :customer_agreement_id

      # Special case for SCE namespacing
      element :'cust:name', as: :customer_agreement_id
    end
  end
end
