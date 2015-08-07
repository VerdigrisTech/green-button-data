module GreenButtonData
  class ModelCollection
    include Enumerable

    def initialize
      @models = []
    end

    def <<(model)
      @models << model
    end

    def each
      return enum_for(:each) unless block_given?

      @models.each do |model|
        yield model
      end
    end

    def last
      @models.last
    end
  end
end
