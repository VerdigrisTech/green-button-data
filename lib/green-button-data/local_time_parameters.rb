module GreenButtonData
  class LocalTimeParameters < Entry
    include Dst

    attr_accessor :dst_offset, :tz_offset

    def dst_starts_at(year = Time.now.year)
      byte_to_dst_datetime(@dst_start_rule, year).to_time
    end

    def dst_ends_at(year = Time.now.year)
      byte_to_dst_datetime(@dst_end_rule, year).to_time
    end

    def total_offset
      @dst_offset + @tz_offset
    end

    def to_h(year = Time.now.year)
      {
        dst: {
          starts_at: dst_starts_at(year),
          ends_at: dst_ends_at(year),
          offset: dst_offset
        },
        tz_offset: tz_offset,
        total_offset: total_offset
      }
    end
  end
end
