module Hotwire #:nodoc:
  
  ##
  # Represents a two dimensional table of data that is ready to format for the Wire protocol
  #
  class Table
    ##
    # Create a table from a source hash. The hash must contain these keys:
    # :columns => A one dimensional array of column labels.
    # :rows => => A two dimensional array of data. Each row is a one dimensional array.
    #
    def initialize source
      raise ArgumentError, "source data must have a :column key and a :rows key" unless source.has_key?(:columns) && source.has_key?(:rows)
      @column_headers = Hotwire::ColumnHeaders.new(source)
      @rows = source[:rows].map { |row| Hotwire::Row.new(row) }
    end
    
    ##
    # Convert the table to a Wire compatible hash
    #
    def to_wire
      {'table' => {'cols' => @column_headers.to_wire, 'rows' => @rows.map {|r| r.to_wire} } }
    end
    
  end
  
end