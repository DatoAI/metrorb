module Metrorb
  module Metrics
    class Accuracy < Metric
      def measure
        reduce_pair { |sum, orig, pred| sum + (orig == pred ? 1 : 0) } / @len.to_f
      end

      def self.name
        Metrorb::USE_I18N ? ::I18n.t('metrorb.metrics.acc') : 'Accuracy'
      end

      # How a list with results from this metric should be ordered from best to worst
      def self.sort_direction
        :desc
      end
    end
  end
end
