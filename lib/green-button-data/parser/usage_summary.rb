module GreenButtonData
  module Parser
    class UsageSummary
      include SAXMachine
      include Enumerations
      include Utilities

      element :billingPeriod, class: Interval, as: :billing_period
      element :billLastPeriod, class: Integer, as: :bill_last_period
      element :billToDate, class: Integer, as: :bill_to_date
      element :costAdditionalLastPeriod, class: Integer,
              as: :cost_additional_last_period
      elements :costAdditionalDetailLastPeriod, class: CostAdditionalDetailLastPeriod,
              as: :cost_additional_detail_last_periods
      element :currency, class: Integer
      element :overallConsumptionLastPeriod, class: SummaryMeasurement,
              as: :overall_consumption_last_period
      element :currentBillingPeriodOverAllConsumption,
              class: SummaryMeasurement,
              as: :current_billing_period_over_all_consumption
      element :currentDayLastYearNetConsumption, class: SummaryMeasurement,
              as: :current_day_last_year_net_consumption
      element :currentDayNetConsumption, class: SummaryMeasurement,
              as: :current_day_net_consumption
      element :currentDayOverallConsumption, class: SummaryMeasurement,
              as: :current_day_overall_consumption
      element :peakDemand, class: SummaryMeasurement, as: :peak_demand
      element :previousDayLastYearOverallConsumption, class: SummaryMeasurement,
              as: :previous_day_last_year_overall_consumption
      element :previousDayNetConsumption, class: SummaryMeasurement,
              as: :previous_day_net_consumption
      element :previousDayOverallConsumption, class: SummaryMeasurement,
              as: :previous_day_overall_consumption
      element :qualityOfReading, class: Integer, as: :quality_of_reading
      element :ratchetDemand, class: SummaryMeasurement, as: :ratchet_demand
      element :ratchetDemandPeriod, class: Interval, as: :ratchet_demand_period
      element :statusTimeStamp, class: Integer, as: :status_time_stamp
      element :commodity, class: Integer
      element :readCycle, as: :read_cycle
      element :tariffProfile, as: :tariff

      def currency
        CURRENCY[@currency]
      end

      def quality_of_reading
        QUALITY_OF_READING[@quality_of_reading]
      end

      def commodity
        COMMODITY[@commodity]
      end

      def status_time_stamp
        Time.at(normalize_epoch(@status_time_stamp)).utc.to_datetime
      end

      # ESPI Namespacing
      element :'espi:billingPeriod', class: Interval, as: :billing_period
      element :'espi:billLastPeriod', class: Integer, as: :bill_last_period
      element :'espi:billToDate', class: Integer, as: :bill_to_date
      element :'espi:costAdditionalLastPeriod', class: Integer,
              as: :cost_additional_last_period
      elements :'espi:costAdditionalDetailLastPeriod', class: CostAdditionalDetailLastPeriod,
              as: :cost_additional_detail_last_periods
      element :'espi:currency', class: Integer, as: :currency
      element :'espi:overallConsumptionLastPeriod', class: SummaryMeasurement,
              as: :overall_consumption_last_period
      element :'espi:currentBillingPeriodOverAllConsumption',
              class: SummaryMeasurement,
              as: :current_billing_period_over_all_consumption
      element :'espi:currentDayLastYearNetConsumption',
              class: SummaryMeasurement,
              as: :current_day_last_year_net_consumption
      element :'espi:currentDayNetConsumption', class: SummaryMeasurement,
              as: :current_day_net_consumption
      element :currentDayOverallConsumption, class: SummaryMeasurement,
              as: :current_day_overall_consumption
      element :'espi:peakDemand', class: SummaryMeasurement, as: :peak_demand
      element :'espi:previousDayLastYearOverallConsumption',
              class: SummaryMeasurement,
              as: :previous_day_last_year_overall_consumption
      element :'espi:previousDayNetConsumption', class: SummaryMeasurement,
              as: :previous_day_net_consumption
      element :'espi:previousDayOverallConsumption', class: SummaryMeasurement,
              as: :previous_day_overall_consumption
      element :'espi:qualityOfReading', class: Integer, as: :quality_of_reading
      element :'espi:ratchetDemand', class: SummaryMeasurement,
              as: :ratchet_demand
      element :'espi:ratchetDemandPeriod', class: Interval,
              as: :ratchet_demand_period
      element :'espi:statusTimeStamp', class: Integer, as: :status_time_stamp
      element :'espi:commodity', class: Integer, as: :commodity
      element :'espi:readCycle', as: :read_cycle
      element :'espi:tariffProfile', as: :tariff

      # Special case for PG&E which uses generic namespacing
      element :'ns0:billingPeriod', class: Interval, as: :billing_period
      element :'ns0:billLastPeriod', class: Integer, as: :bill_last_period
      element :'ns0:billToDate', class: Integer, as: :bill_to_date
      element :'ns0:costAdditionalLastPeriod', class: Integer,
              as: :cost_additional_last_period
      elements :'ns0:costAdditionalDetailLastPeriod', class: CostAdditionalDetailLastPeriod,
              as: :cost_additional_detail_last_periods
      element :'ns0:currency', class: Integer, as: :currency
      element :'ns0:overallConsumptionLastPeriod', class: SummaryMeasurement,
              as: :overall_consumption_last_period
      element :'ns0:currentBillingPeriodOverAllConsumption',
              class: SummaryMeasurement,
              as: :current_billing_period_over_all_consumption
      element :'ns0:currentDayLastYearNetConsumption',
              class: SummaryMeasurement,
              as: :current_day_last_year_net_consumption
      element :'ns0:currentDayNetConsumption', class: SummaryMeasurement,
              as: :current_day_net_consumption
      element :currentDayOverallConsumption, class: SummaryMeasurement,
              as: :current_day_overall_consumption
      element :'ns0:peakDemand', class: SummaryMeasurement, as: :peak_demand
      element :'ns0:previousDayLastYearOverallConsumption',
              class: SummaryMeasurement,
              as: :previous_day_last_year_overall_consumption
      element :'ns0:previousDayNetConsumption', class: SummaryMeasurement,
              as: :previous_day_net_consumption
      element :'ns0:previousDayOverallConsumption', class: SummaryMeasurement,
              as: :previous_day_overall_consumption
      element :'ns0:qualityOfReading', class: Integer, as: :quality_of_reading
      element :'ns0:ratchetDemand', class: SummaryMeasurement,
              as: :ratchet_demand
      element :'ns0:ratchetDemandPeriod', class: Interval,
              as: :ratchet_demand_period
      element :'ns0:statusTimeStamp', class: Integer, as: :status_time_stamp
      element :'ns0:commodity', class: Integer, as: :commodity
      element :'ns0:readCycle', as: :read_cycle
      element :'ns0:tariffProfile', as: :tariff
    end
  end
end
