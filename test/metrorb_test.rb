require 'test_helper'

def csv_io(name)
  File.open(File.join(File.expand_path('../data', __FILE__), name))
end

class CalculateTest < Minitest::Test
  parallelize_me!

  def test_it_hides_the_initializer
    assert_raises { Metrorb::Calculate.new([1, 2], [3, 4]) }
  end

  def test_it_validates_the_arrays_size
    error = assert_raises { Metrorb::Calculate.from_arrays([1, 2], [1, 2, 3]) }
    assert_equal 'The original and prediction arrays must have the same size!', error.to_s
  end

  def test_it_calculates_accuracy_from_arrays
    assert_equal 0.2, calc_from_arrays(:acc, [1, 0, 0, 0, 0], [1, 1, 1, 1, 1])
    assert_equal 0.4, calc_from_arrays(:acc, [1, 1, 0, 0, 0], [1, 1, 1, 1, 1])
    assert_equal 0.6, calc_from_arrays(:acc, [1, 1, 1, 0, 0], [1, 1, 1, 1, 1])
    assert_equal 0.8, calc_from_arrays(:acc, [1, 1, 1, 1, 0], [1, 1, 1, 1, 1])
  end

  def test_it_calculates_mae_from_arrays
    assert_equal 0.0, calc_from_arrays(:mae, [   0,    0,    0,     0,      0], [   0,    0,    0,     0,      0])
    assert_equal 0.0, calc_from_arrays(:mae, [   4,    2,    3,     8,     20], [   4,    2,    3,     8,     20])
    assert_equal 0.0, calc_from_arrays(:mae, [43.5, 12.3, 98.7, 107.2, 502.33], [43.5, 12.3, 98.7, 107.2, 502.33])
    assert_equal 4.4, calc_from_arrays(:mae, [  44,   17,   33,    21,     57], [  48,   12,   35,    28,     53])
    assert_equal 3.0, calc_from_arrays(:mae, [  38,   42,   47,    55],         [  40,   40,   50,    50])
  end

  def test_it_calculates_mae_from_csvs
    assert_equal 0.0, Metrorb::Calculate.from_csvs(csv_io('orig1.csv'), csv_io('pred1.csv')).mae
    assert_equal 0.0, Metrorb::Calculate.from_csvs(csv_io('unsorted_ids_orig.csv'), csv_io('unsorted_ids_pred.csv')).mae
    assert_equal 0.0, Metrorb::Calculate.from_csvs(csv_io('messed_label_orig.csv'), csv_io('messed_label_pred.csv')).mae
    assert_equal 2.0, Metrorb::Calculate.from_csvs(csv_io('custom_label_orig.csv'), csv_io('custom_label_pred.csv'), id: :customidentifier, value: :customlabelvalue).mae
  end

  def test_it_throws_an_error_if_the_prediction_csv_miss_ids
    error = assert_raises { Metrorb::Calculate.from_csvs(csv_io('bad_orig.csv'), csv_io('bad_pred.csv')) }
    assert_equal [5], error.ids
    assert_equal 'Missing IDs in the prediction csv: [5]', error.to_s
  end

  def calc_from_arrays(metric, orig, pred)
    Metrorb::Calculate.from_arrays(orig, pred).send(metric)
  end
end

class CsvExtractorTest < Minitest::Test
  parallelize_me!

  def test_it_extract_arrays_from_commom_csv
    ordered_csvs = Metrorb::CsvExtractor.new(csv_io('orig1.csv'), csv_io('pred1.csv')).extract_arrays
    assert_equal [2, 3, 5, 7, 11], ordered_csvs[0]
    assert_equal [2, 3, 5, 7, 11], ordered_csvs[1]
  end

  def test_it_extract_arrays_from_unsorted_csv
    unordered_csvs = Metrorb::CsvExtractor.new(csv_io('unsorted_ids_orig.csv'), csv_io('unsorted_ids_pred.csv')).extract_arrays
    assert_equal unordered_csvs[0], unordered_csvs[1]
  end

  def test_it_extract_arrays_from_bad_formatted_csv
    messed_label_csv = Metrorb::CsvExtractor.new(csv_io('messed_label_orig.csv'), csv_io('messed_label_pred.csv')).extract_arrays
    assert_equal [2, 3, 5, 7, 11], messed_label_csv[0]
    assert_equal [2, 3, 5, 7, 11], messed_label_csv[1]
  end

  def test_it_extract_arrays_from_csv_with_custom_label
    messed_label_csv = Metrorb::CsvExtractor.new(csv_io('custom_label_orig.csv'), csv_io('custom_label_pred.csv'), id: :customidentifier, value: :customlabelvalue).extract_arrays
    assert_equal [2, 3, 5, 7, 11], messed_label_csv[0]
    assert_equal [4, 4, 8, 9, 13], messed_label_csv[1]
  end

  def test_it_shows_missing_ids_in_prediction_csv
    assert_equal [], Metrorb::CsvExtractor.new(csv_io('orig1.csv'), csv_io('pred1.csv')).missing_ids
    assert_equal [5], Metrorb::CsvExtractor.new(csv_io('bad_orig.csv'), csv_io('bad_pred.csv')).missing_ids
  end
end

# =============
# Metrics tests
# =============

class AccuracyTest < Minitest::Test
  def test_it_has_a_name
    assert_equal 'Accuracy', Metrorb::Metrics::Accuracy.name
  end

  def test_it_has_a_sort_direction
    assert_equal :desc, Metrorb::Metrics::Accuracy.sort_direction
  end
end

class MeanAbsoluteErrorTest < Minitest::Test
  def test_it_has_a_name
    assert_equal 'Mean Absolute Error', Metrorb::Metrics::MeanAbsoluteError.name
  end

  def test_it_has_a_sort_direction
    assert_equal :asc, Metrorb::Metrics::MeanAbsoluteError.sort_direction
  end
end
