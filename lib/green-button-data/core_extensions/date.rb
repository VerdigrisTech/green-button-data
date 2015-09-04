class Date
  def utc
    self.new_offset(0)
  end

  def local
    new_offset(DateTime.now.offset - offset)
  end
end
