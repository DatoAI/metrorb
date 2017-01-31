require 'metrorb/metric'
require 'metrorb/metrics/accuracy'
require 'metrorb/metrics/mean_absolute_error'
require 'csv'
require 'metrorb/csv_extractor'
require 'metrorb/calculate'

if defined?(I18n)
  require 'metrorb/i18n/i18n'
  Metrorb::I18n.load_locales!
  Metrorb.const_set('USE_I18N', true)
else
  Metrorb.const_set('USE_I18N', false)
end

module Metrorb
  def self.metrics
    [
      Metrorb::Metrics::Accuracy,
      Metrorb::Metrics::MeanAbsoluteError
    ]
  end

  def self.metrics_name
    metrics.map(&:name)
  end

  def self.metrics_name_and_abbr
    metrics.map { |metric| [metric.name, metric.abbr] }
  end

  def self.metrics_abbr_and_id
    metrics.each_with_object({}) do |metric, h|
      h[metric.abbr] = metric.id
    end
  end
end
