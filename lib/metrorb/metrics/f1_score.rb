module Metrorb
  module Metrics
    class F1Score < Metric
      def measure
        $y_pred_positive = 0
        $y_true_positive = 0
        precision = reduce_pair { |sum, orig, pred| $y_pred_positive += 1 if pred == 1 
          sum + ((pred == 1 && orig == pred) ? 1 : 0)
        } / $y_pred_positive.to_f 
        
        recall = reduce_pair { |sum, orig, pred| $y_true_positive += 1 if orig == 1 
          sum + ((orig == 1 && orig == pred) ? 1 : 0)
        } / $y_true_positive.to_f 
        
        if precision + recall == 0
          return 0.0  
        end

        2 * (precision * recall) / (precision + recall)
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
