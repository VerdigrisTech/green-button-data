module GreenButtonData
  module Parser
    class MainAddress
      include SAXMachine

      def town_detail_info
        town_detail.name + ',' + town_detail.code.gsub(/\s+/, "") + ',' + town_detail.state_or_province
      end

      def address_general
        street_detail.address_general
      end

      def to_s
        address_general + ',' + town_detail_info
      end

      element :town_detail, class: TownDetail, as: :town_detail
      element :street_detail, class: StreetDetail, as: :town_detail


      # ESPI Namespacing
      element :'espi:townDetail', class: TownDetail, as: :town_detail
      element :'espi:streetDetail', class: StreetDetail, as: :street_detail

      # Special case for PG&E generic namespacing
      element :'ns0:townDetail', class: TownDetail, as: :town_detail
      element :'ns0:streetDetail', class: StreetDetail, as: :street_detail
    end
  end
end
