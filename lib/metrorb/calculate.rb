require 'bigdecimal'
require 'bigdecimal/util'

module Metrorb
  class Calculate
    def self.from_arrays(orig, pred)
      raise ArgumentError.new("The measured arrays must have the same size!") if orig.size != pred.size
      new(orig, pred)
    end

    def self.from_csvs(csv1, csv2, options = {})
      from_arrays(*CsvExtractor.new(csv1, csv2, options).extract_arrays)
    end

    def mae
      MeanAbsoluteError.new(@orig, @pred).measure
    end
    alias mean_absolute_error mae

    private

    private_class_method :new

    def initialize(orig, pred)
      @orig = orig.map(&:to_d)
      @pred = pred.map(&:to_d)
    end
  end
end