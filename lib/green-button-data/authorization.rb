module GreenButtonData
  class Authorization < Entry
    include Enumerations

    attr_reader :id

    attr_accessor :authorized_period,
                  :published_period,
                  :expires_at,
                  :status,
                  :resource_uri,
                  :authorization_uri

    def initialize(attributes)
      super

      if attributes[:status].is_a? Numeric
        @status = AUTHORIZATION_STATUS[attributes[:status]]
      elsif attributes[:status].is_a? Symbol
        @status = attributes[:status]
      end
    end

    def active?
      @status > 0
    end
  end
end
