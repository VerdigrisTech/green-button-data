module GreenButtonData
  class MeterReading < Entry
    def interval_blocks(id = nil)
      if id.nil?
        @interval_blocks ||= IntervalBlock.all @interval_block_url

        return @interval_blocks
      else
        # Try returning cached results first
        @interval_blocks and interval_block = @interval_blocks.find_by_id(id)
        cache_miss = interval_block.nil?

        # Cache-miss; send API request
        interval_block ||= IntervalBlock.find("#{@interval_block_url}/#{id}")

        # Cache the result
        unless @interval_blocks
          @interval_blocks = ModelCollection.new
          @interval_blocks << interval_block if cache_miss
        end

        return interval_block
      end
    end
  end
end
