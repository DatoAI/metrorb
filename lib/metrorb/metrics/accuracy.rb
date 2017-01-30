module Metrorb
  module Metrics
    class Accuracy < Metric
      def measure
        reduce_pair { |sum, orig, pred| sum + (orig == pred ? 1 : 0) } / @len.to_f
      end
    end
  end
end
