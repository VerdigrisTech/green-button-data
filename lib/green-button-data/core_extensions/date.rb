Date.class_eval do
  unless Date.new.respond_to? :utc
    def utc
      self.new_offset(0)
    end
  end

  unless Date.new.respond_to? :local
    def local
      new_offset(DateTime.now.offset - offset)
    end
  end
end # Date.class_eval
