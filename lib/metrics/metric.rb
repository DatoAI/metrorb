module Metrror
  class Metric
    def initialize(pred, orig)
      @pred = pred
      @orig = orig
      @len = @orig.size
    end
  end
end
