module Metrorb
  module Metrics
    class F1Score < Metric
      def measure
        $positive_class = 0
        reduce_pair { |sum, orig, pred| $positive_class += 1 if pred == 1 
          sum + ((pred == 1 && orig == pred) ? 1 : 0)
        } / $positive_class.to_f
      end

      def self.abbr
        :f1s
      end

      def self.id
        2
      end

      def self.name
        Metrorb::USE_I18N ? ::I18n.t('metrorb.metrics.f1s') : 'F1 Score'
      end

      # How a list with results from this metric should be ordered from best to worst
      def self.sort_direction
        :desc
      end
    end
  end
end
