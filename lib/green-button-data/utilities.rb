module GreenButtonData
  module Utilities

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
        epoch / 100000
      elsif epoch.digits >= 13
        epoch / 1000
      else
        epoch
      end
    end

    def epoch_to_time(epoch, kwargs = {})
      time = Time.at normalize_epoch(epoch)

      if kwargs[:local] == true
        return time.localtime
      else
        return time.utc
      end
    end

    ##
    # Retrieves the first Sunday of the month
    #
    # ==== Arguments
    #
    # * +year+ - year
    # * +month+ - month
    def first_sunday_of(year = Time.now.year, month = Time.now.month)
      first_day = DateTime.new(year, month, 1)
      first_weekday = first_day.wday

      # If today is Sunday, no offset, otherwise, calculate number of days that
      # need to be added before hitting the first Sunday of month
      day_offset = first_weekday == 0 ? 0 : 7 - first_weekday

      # Return first Sunday of the month
      first_day + day_offset
    end

    ##
    # Returns the Nth weekday in the given month
    #
    # ==== Arguments
    #
    # * +year+ - year
    # * +month+ - month
    # * +weekday+ - day of week; 0 = Sunday, 6 = Saturday
    # * +week+ - Nth week of month
    #
    # ==== Examples
    #
    # To retrieve third Friday of July 2015,
    #     nth_weekday_of 2015, 7, 5, 3
    def nth_weekday_of(year = Time.now.year, month = Time.now.month,
                       weekday = 0, week = 1)
      first_day = DateTime.new year, month, 1

      # Day offset needed for Nth day of the week
      first_day + weekday_offset(first_day.wday, weekday) + (week - 1) * 7
    end

    ##
    # Returns the last weekday in the given month
    #
    # ==== Arguments
    #
    # * +year+ - year
    # * +month+ - month
    # * +weekday+ - day of week; 0 = Sunday, 6 = Saturday
    #
    # ==== Examples
    #
    # To retrieve the last Wednesday of September 2015,
    #     last_weekday_of 2015, 9, 3
    def last_weekday_of(year = Time.now.year, month = Time.now.month,
                        weekday = 0)

      # Get the last day of month
      last_day = DateTime.new year, month, -1
      last_weekday = last_day.wday

      day_offset = if last_weekday >= weekday
        last_weekday - weekday
      else
        7 + last_weekday - weekday
      end

      last_day - weekday_offset(weekday, last_weekday)
    end

    def weekday_offset(first_weekday, second_weekday)
      if second_weekday >= first_weekday
        second_weekday - first_weekday
      else
        7 + second_weekday - first_weekday
      end
    end

    ##
    # Returns a hash representation of object instance's attributes
    #
    # ==== Arguments
    #
    # * +obj+ - an object
    def attributes_to_hash(obj)
      attributes_hash = {}

      obj.instance_variables.each do |var|
        attr_name = var.to_s.delete('@').to_sym
        attributes_hash[attr_name] = obj.instance_variable_get(var)
      end

      return attributes_hash
    end

    def class_from_name(class_name)
      class_name or raise ArgumentError.new "Class name is required"
      class_name.split('::').inject(Object) { |obj, cls| obj.const_get cls }
    end
  end
end
