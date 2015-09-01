module GreenButtonData
  class Authorization < Entry
    include Enumerations
    include Utilities

    attr_reader :id

    attr_accessor :authorized_period,
                  :published_period,
                  :expires_at,
                  :status,
                  :resource_uri,
                  :authorization_uri

    def active?
      @status > 0
    end

    def expires_at
      if @expires_at.is_a? Numeric
        epoch_to_time @expires_at
      elsif @expires_at.is_a? String
        parse_datetime(@expires_at).to_time
      elsif @expires_at.respond_to? :to_time
        @expires_at.to_time
      else
        raise "Invalid expires_at type"
      end
    end

    def status
      get_enum_symbol AUTHORIZATION_STATUS, @status
    end
  end
end
