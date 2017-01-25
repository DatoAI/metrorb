module Metrorb
  class Metric
    def initialize(orig, pred)
      @orig = orig
      @pred = pred
      @len = @orig.size
    end

    def reduce_pair(initial = 0)
      (0...@len).reduce(initial) do |mem, i|
        yield(mem, @orig[i], @pred[i])
      end
    end
  end
end
