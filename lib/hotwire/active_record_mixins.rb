module Hotwire #:nodoc:
  
  ##
  # Hotwire extensions to build from ActiveRecord collections
  #
  module ActiveRecordMixins
    
    ##
    # Extensions to Hotwire::Table
    #
    module Table
    private
      def self.included base
        base.class_eval do
          alias_method_chain :initialize, :active_record_extension
        end
      end
      
      ##
      # Parse source data if needed and then pass it along to main initializer
      #
      def initialize_with_active_record_extension source
        source = source_from_active_record_collection(source) if source.is_a?(Array) and source.first.is_a?(ActiveRecord::Base)
        initialize_without_active_record_extension source
      end
    
      ##
      # Parse an ActiveRecord collection into a hash for the initializer
      #
      def source_from_active_record_collection source
        { :columns => columns_from_active_record_collection(source), :rows => rows_from_active_record_collection(source) }
      end
    
      ##
      # Parse an ActiveRecord collection into a column headers array
      #
      def columns_from_active_record_collection source
        attrs = source.first.attributes.clone
        attrs.delete('id')
        attrs.keys.sort
      end
      
      ##
      # Parse an ActiveRecord collection into a rows array
      #
      def rows_from_active_record_collection source
        source.map do |obj| 
          attrs = obj.attributes.clone
          attrs.delete('id')
          attrs.sort_by{ |key, val| key }.map do |key, val|
            val
          end
        end
      end
    end
    
    ##
    # Extensions to Hotwire::Row
    #
    module Row
    private
      ##
      # Times pulled from an activerecord attribute hash are not converted to the zone automatically
      #
      def format_date_with_time_zone_conversion date
        date = date.in_time_zone if Time.respond_to?(:zone) and Time.zone and date.respond_to?(:in_time_zone)
        format_date_without_time_zone_conversion date
      end
      
      def self.included base
        base.class_eval do
          alias_method_chain :format_date, :time_zone_conversion
        end
      end
    end
    
    ##
    # Extensions to Hotwire::CoreExtensions
    #
    module CoreExtensions
      
      module Array
        ##
        # Converts an ActiveRecord collection array to a Wire compatible hash
        #
        def to_wire
          raise "to_wire only works on an array of ActiveRecord objects" if self.map {|elem| elem.is_a?(ActiveRecord::Base)}.include?(false)
          Hotwire::Table.new(self).to_wire
        end
      end
    end
     
  end
  
end

Hotwire::Table.send(:include, Hotwire::ActiveRecordMixins::Table) 
Hotwire::Row.send(:include, Hotwire::ActiveRecordMixins::Row) 
Array.send(:include, Hotwire::ActiveRecordMixins::CoreExtensions::Array)