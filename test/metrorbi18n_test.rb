require 'test_helper'
require 'i18n'
I18n.available_locales = [:en, :'pt-BR']
Metrorb.send(:remove_const, :USE_I18N)
# Reload metrorb.rb to include I18n relevant code now
load 'metrorb.rb'

class I18nTest < Minitest::Test
  def setup
    I18n.locale = :en
  end

  def test_it_translates_to_en
    I18n.locale = :en
    assert_equal 'Accuracy', Metrorb::Metrics::Accuracy.name
    assert_equal 'Mean Absolute Error', Metrorb::Metrics::MeanAbsoluteError.name
  end

  def test_it_translates_to_ptBR
    I18n.locale = :'pt-BR'
    assert_equal 'Acurácia', Metrorb::Metrics::Accuracy.name
    assert_equal 'Média dos Errors Absolutos', Metrorb::Metrics::MeanAbsoluteError.name
  end

  def teardown
    I18n.locale = :en
  end
end
