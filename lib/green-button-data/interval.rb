module GreenButtonData
  module Interval
    attr_accessor :starts_at, :ends_at, :duration

    def ends_at
      @ends_at ||= (duration / 86400.0) + @starts_at
    end

    def duration
      @duration ||= ((@ends_at - @starts_at) * 86400).to_i if @ends_at
    end
  end
end
