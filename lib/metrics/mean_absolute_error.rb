module Metrror
  class MeanAbsoluteError < Metric
    def measure
      (0...@len).reduce(0) { |sum, i| sum + (@orig[i] - @pred[i]).abs } / @len.to_f
    end
  end
end
