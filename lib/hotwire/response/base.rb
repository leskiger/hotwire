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
        raise ArgumentError.new("Invalid column type: #{type}") if !@coltypes.include?(type)
        params ||= {}
        params[:type] = type
    
        # TODO: passing a wront type in params bypasses the previous type check.
        @columns << params.delete_if { |k,v| !@colkeys.include?(k) }
        return self
      end
      alias_method :add_col, :add_column
  
      # Sets the data to be exported. +data+ should be a 2-dimensional array. The 
      # first index should iterate over rows, the second over columns. Column 
      # ordering must be the same used in +add_col+ invokations.
      #
      # Anything that behaves like a 2-dimensional array and supports +each+ is
      # a perfectly fine alternative.
      def set_data(data)
        @data = data
        return self
      end
      
      # Placeholder method for the subclasses to overwrite
      def body
      end
    end
    
  end
end