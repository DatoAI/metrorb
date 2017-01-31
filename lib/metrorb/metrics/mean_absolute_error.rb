module Metrorb
  module Metrics
    class MeanAbsoluteError < Metric
      def measure
        reduce_pair { |sum, orig, pred| sum + (orig - pred).abs } / @len.to_f
      end

      def self.abbr
        :mae
      end

      def self.id
        0
      end

      def self.name
        Metrorb::USE_I18N ? ::I18n.t('metrorb.metrics.mae') : 'Mean Absolute Error'
      end

      # How a list with results from this metric should be ordered from best to worst
      def self.sort_direction
        :asc
      end
    end
  end
end
