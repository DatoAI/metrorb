require 'test_helper'

class MeanAbsoluteErrorTest < Minitest::Test
  def test_it_calculates_correctly
    assert_equal 0.0, calc_mae([   0,    0,    0,     0,      0], [   0,    0,    0,     0,      0])
    assert_equal 0.0, calc_mae([   4,    2,    3,     8,     20], [   4,    2,    3,     8,     20])
    assert_equal 0.0, calc_mae([43.5, 12.3, 98.7, 107.2, 502.33], [43.5, 12.3, 98.7, 107.2, 502.33])
    assert_equal 4.4, calc_mae([  44,   17,   33,    21,     57], [  48,   12,   35,    28,     53])
    assert_equal 3.0, calc_mae([  38,   42,   47,    55],         [  40,   40,   50,    50])
  end

  def calc_mae(pred, orig)
    Metrror::MeanAbsoluteError.new(pred, orig).measure
  end
end
