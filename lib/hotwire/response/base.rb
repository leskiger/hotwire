module Hotwire
  module Response
    class Base < Hotwire::Base
      attr_reader :data, :columns
      # Creates a new instance and validates it. 
      def initialize(request)
        super
        @request = request
        @columns = []
        @data = []
        @version = "0.5"
        @coltypes = [ "boolean", "number", "string", "date", "datetime", "timeofday"]
        @colkeys = [ :type, :id, :label, :pattern]
      end
    
      # Adds a new column to the visualization. This method can be invoked as many
      # times as the number of columns to export in the visualiation. Invocations can
      # be chained.
      #
      # Invocation order is important! The same order will be expected when setting
      # the actual data and to produce the response.
      #
      # +type+ must be one of the supported Wire datatypes, or an +ArgumentError+ will
      # be raised. +params+ is an optional map to define extra column attributes. 
      # These include: +:id+, +:label+ and +:pattern+.
      def add_column(type, params=nil)
        raise ArgumentError.new("Invalid column type: #{type}(#{type.class.name})") if !@coltypes.include?(type)
        params ||= {}
        params[:type] = type
    
        # TODO: passing a wront type in params bypasses the previous type check.
        @columns << params.delete_if { |k,v| !@colkeys.include?(k) }
        return self
      end
      alias_method :add_col, :add_column
      
      # Adds a colleciton of columns to the visualization
      # +columns+ can either be an array of column definitions:
      #   add_columns(['string', {:id => 'Column A'}], ['number', {:id => 'Column B'}])
      #
      # or a sample row of data, represented as a hash keyed as column_name => value:
      #   add_columns({'column_a' => 'a1', 'column_b' => 'b1})
      # column_name keys are expected to be strings.
      def add_columns(columns)
        if columns.first.is_a?(Hash)
          add_columns_from_data_hash(columns)
        else
          add_columns_from_array(columns)
        end
      end
  
      # Sets the data to be exported. 
      # +data+ can be a 2-dimensional array of plain data, an array of hashes that are keyed 
      # column_name => value, or a hash with a :columns key and a :rows key 
      # 
      # If passing a 2-dimensional array, the first index should iterate over rows, 
      # the second over columns. Column ordering must be the same used in +add_col+ 
      # invokations. Anything that behaves like a 2-dimensional array and supports +each+ is
      # a perfectly fine alternative.
      #
      # If passing an array of column_name => value hashes and no columns have been added,
      # a column will automatically be added for each entry in the first row of data.
      # If columns have already been added then the data will be filtered to those
      # columns. column_name keys are expected to be strings.
      #
      # If passing a hash with :columns key and a :rows key, 
      # :columns should be an array of column ids: ['col_a', 'col_b'...'col_N']
      # :rows should be a 2-dimensional array of data: [['a1', 'b1']...['aN', 'bN']]
      # Note that each row of data must be in the same order as the column id array.
      def set_data(data)
        if data.is_a?(Hash)
          set_data_from_hash(data)
        elsif data.first.is_a?(Hash)
          set_data_from_array_of_hashes(data)
        else
          set_data_from_array(data)
        end
        return self
      end
      
      # Placeholder method for the subclasses to overwrite
      def body
      end
      
    protected
    
      # Adds columns to the response based on a sample row of data in the form of a hash
      # keyed as column_name => value
      def add_columns_from_data_hash(data)
        data.first.sort.each do |key, value|
          add_column(column_type_for_value(value), :id => key.to_s, :label => key.to_s)
        end
      end
      
      # Determines the appropriate Wire Protocol column type for +value+
      def column_type_for_value(value)
        case value.class.name
        when 'BigDecimal', 'Fixnum', 'Float'
          'number'
        when /Time/
          'datetime'
        when 'Date'
          'date'
        when 'String'
          'string'
        else
          'string'
        end
      end
      
      # Adds multiple columns to the response from an array of column definitions:
      #   add_columns(['string', {:id => 'Column A'}], ['number', {:id => 'Column B'}])
      def add_columns_from_array(columns)
        columns.each { |col| add_column(*col)}
      end
      
      # Sets up the response based on a hash that has a :columns key and a :rows key.
      # :columns should be an array of column ids: ['col_a', 'col_b'...'col_N']
      # :rows should be a 2-dimensional array of data: [['a1', 'b1']...['aN', 'bN']]
      # This method adds columns based on the first row of data and the provided
      # array of column ids. Note that each row of data must be in the same
      # order as the column id array.
      def set_data_from_hash(data)
        data[:columns].each_with_index do |column_name, index|
          sample_value = data[:rows].first[index]
          add_column(column_type_for_value(sample_value), :id => column_name, :label => column_name)
        end
        set_data_from_array(data[:rows])
      end
      
      # Sets the response data from an array of row hashes that are keyed column_name => value.
      # If there are no columns setup, they are added automatically.
      # Data is filtered on the columns that exist.
      def set_data_from_array_of_hashes(data)
        add_columns(data) if columns.empty?
        set_data(data.map { |row| self.columns.map { |c| row[c[:id].to_s] } })
      end
      
      # Sets the response data from a two dimensional array of innumerables.
      def set_data_from_array(data)
        @data = data
      end
      
    end
    
  end
end