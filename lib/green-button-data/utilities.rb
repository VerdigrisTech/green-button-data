module GreenButtonData
  module Utilities
    include Enumerable

    def parse_datetime(string)
      begin
        DateTime.parse(string).utc
      rescue
        warn "Parsing failed for string: #{string.inspect}"
        nil
      end
    end

    ##
    # Normalizes UNIX +epoch+ ticks to seconds.
    #
    # If the number of digits for +epoch+ are greater than or equal to 15
    # decimal digits, it assumes that the +epoch+ is in microseconds.
    #
    # If the number of digits for +epoch+ are less than 15 but greater than or
    # equal to 13 decimal digits, it assumes that +epoch+ is in milliseconds.
    #
    # Less than 13 digits is assumed to be in seconds.
    #
    # ==== Arguments
    #
    # * +epoch+ - Amount of seconds/milliseconds/microseconds since 1970-01-01
    def normalize_epoch(epoch)
      if epoch.digits >= 15
        epoch / 1000000
      elsif epoch.digits >= 13
        epoch / 1000
      else
        epoch
      end
    end
  end
end
