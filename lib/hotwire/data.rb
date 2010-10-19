module Hotwire #:nodoc:
  
  class Data
    def initialize source
      raise ArgumentError, "source data must have a :column key and a :rows key" unless source.has_key?(:columns) && source.has_key?(:rows)
      @column_headers = Hotwire::ColumnHeaders.new(source)
      @rows = source[:rows].map { |row| Hotwire::Row.new(row) }
    end
    
    def to_wire
      {'table' => {'cols' => @column_headers.to_wire, 'rows' => @rows.map {|r| r.to_wire} } }
    end
    
  end
  
end