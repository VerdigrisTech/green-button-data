class Date
  def utc
    self.new_offset(0)
  end

  def local
    dest = new_offset(DateTime.now.offset - offset)
    Time.send :local, dest.year, dest.month, dest.day, dest.hour, dest.min,
              dest.sec, dest.zone
  end
end
