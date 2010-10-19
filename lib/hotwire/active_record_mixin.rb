module Hotwire #:nodoc:
  
  module ActiveRecordMixin
    def self.included base
      Array.send(:include, ArrayInstanceMethods)
      base.send(:include, DataInstanceMethods)
      base.class_eval do
        alias_method_chain :initialize, :active_record_extension
      end
    end
    
    module DataInstanceMethods
    
    private
  
      def initialize_with_active_record_extension source
        source = source_from_active_record_collection(source) if source.is_a?(Array) and source.first.is_a?(ActiveRecord::Base)
        initialize_without_active_record_extension source
      end
    
      def source_from_active_record_collection source
        { :columns => columns_from_active_record_collection(source), :rows => rows_from_active_record_collection(source) }
      end
    
      def columns_from_active_record_collection source
        source.first.attributes.keys.sort
      end
    
      def rows_from_active_record_collection source
        source.map do |obj| 
          obj.attributes.sort_by{ |key, val| key }.map do |key, val|
            val
          end
        end
      end
    end
    
    module ArrayInstanceMethods
      # Returns a new Wire formatted hash. Elements of the array must be ActiveRecord Models
      def to_wire
        raise "to_wire only works on an array of ActiveRecord objects" if self.map {|elem| elem.is_a?(ActiveRecord::Base)}.include?(false)
        Hotwire::Data.new(self).to_wire
      end
    end
    
  end
  
end