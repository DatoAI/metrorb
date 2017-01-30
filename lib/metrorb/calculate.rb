require 'bigdecimal'
require 'bigdecimal/util'

module Metrorb
  class Calculate
    def self.from_arrays(orig, pred)
      raise ArgumentError.new("The original and prediction arrays must have the same size!") if orig.size != pred.size
      new(orig, pred)
    end

    def self.from_csvs(orig, pred, options = {})
      extractor = CsvExtractor.new(orig, pred, options)
      if extractor.missing_ids.empty?
        from_arrays(*extractor.extract_arrays)
      else
        raise BadCsvError.new(extractor.missing_ids)
      end
    end

    def mae
      Metrics::MeanAbsoluteError.new(@orig, @pred).measure
    end
    alias mean_absolute_error mae

    def acc
      Metrics::Accuracy.new(@orig, @pred).measure
    end
    alias accuracy mae

    private

    private_class_method :new

    def initialize(orig, pred)
      @orig = orig.map(&:to_d)
      @pred = pred.map(&:to_d)
    end
  end

  class BadCsvError < StandardError
    attr_reader :ids
    def initialize(ids = nil); @ids = ids; end
    def to_s; "Missing IDs in the prediction csv: #{@ids}"; end
  end
end
