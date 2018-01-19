module Metrorb
  class CsvExtractor

    LABELS = { id: :id, value: :value }

    CSV_OPT = {
      headers: true,
      converters: :numeric,
      header_converters: :symbol
    }

    def initialize(csv1, csv2, options = {})
      opts = LABELS.merge(options)
      @id, @val1, @val2 = opts[:id], opts[:value], :value2
      @table = merge(CSV.new(csv1, CSV_OPT).read, CSV.new(csv2, CSV_OPT).read)
    end

    def extract_arrays
      return @table[@val1], @table[@val2]
    end

    def missing_ids
      @missing_ids ||= @table.select { |r| r[@val2].nil? }.map { |r| r[@id] }
    end

    private

    # O(n²)
    # def merge(left, right)
    #   left.each do |lrow|
    #     right.each do |rrow|
    #       if rrow[@id] == lrow[@id]
    #         lrow << [@val2, rrow[@val1]]
    #         next
    #       end
    #     end
    #   end
    # end

    def merge(left, right)
      if left[@id].eql?(right[@id]) #if the ids of the vectors are equal
        left.each_with_index do |lrow, index|
          lrow << [@val2, right[index][@val1]]
          next
        end  
      else
        ids_left = left[@id] - right[@id] #ids that have in left that do not have in right
        left.each do |lrow|
          unless ([lrow[@id]] - ids_left).empty?
            lrow << [@val2, lrow[@val1]]
            next
          end 
        end  
      end  
    end
    
  end
end
