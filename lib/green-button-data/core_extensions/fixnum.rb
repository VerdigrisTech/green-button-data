Fixnum.class_eval do
  unless 0.respond_to? :digits
    def digits(base = 10)
      num = self.abs
      if num == 0
        1
      else
        Math.log10(num).floor + 1
      end
    end
  end
end # Fixnum.class_eval
