module Metrorb
  module Metrics
    class MeanAbsoluteError < Metric
      def measure
        reduce_pair { |sum, orig, pred| sum + (orig - pred).abs } / @len.to_f
      end
    end
  end
end
