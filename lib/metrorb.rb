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
