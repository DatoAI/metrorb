module Metrorb
  class CsvExtractor

    LABELS = { id: :id, value: :value }

    CSV_OPT = {
      headers: true,
      converters: :numeric,
      header_converters: :symbol
    }

    def initialize(csv1, csv2, options = {})
      @opts = LABELS.merge(options)
      @table = merge(CSV.new(csv1, CSV_OPT).read, CSV.new(csv2, CSV_OPT).read)
    end

    def extract_arrays
      return @table[@opts[:value]], @table[:value2]
    end

    private

    # O(n²)
    def merge(left, right)
      left.each do |lrow|
        right.each do |rrow|
          if rrow[@opts[:id]] == lrow[@opts[:id]]
            lrow << [:value2, rrow[@opts[:value]]]
            next
          end
        end
      end
    end
  end
end
