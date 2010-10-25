module Hotwire
  module Response
    
    # This mixin adds the ability to pass an ActiveRecord model to add_columns
    module ActiveRecordMixin
      def add_columns_with_active_record_model(args)
        if args.respond_to?(:ancestors) and args.ancestors.include? ActiveRecord::Base
          args = args.columns.sort_by{|c| c.name }.map do |col| 
            [normalize_active_record_type(col.type), {:id => col.name, :label => col.name }]
          end
        end
        add_columns_without_active_record_model(args) 
        
      end
      
      def set_data_with_active_record_collection(data)
        data = rows_from_active_record_collection(data) if data.first.is_a?(ActiveRecord::Base)
        set_data_without_active_record_collection(data)
      end
      
      def self.included(base)
        base.send :alias_method_chain, :add_columns, :active_record_model
        base.send :alias_method_chain, :set_data, :active_record_collection
      end
      
    private
      
      # Converts an Array of ActiveRecord objects to an Array of data points based on columns setup for the response.
      def rows_from_active_record_collection(collection)
        collection.map { |obj| self.columns.map { |c| obj[c[:id]] } }
      end
      
      # Convert an ActiveRecord type string to Wire Protocol types
      def normalize_active_record_type(type)
        case type
        when :timestamp
          'datetime'
        when :string, :text
          'string'
        when :decimal, :integer
          'number'
        else
          type.to_s
        end
      end
      
    end
  end
end

Hotwire::Response::Base.send :include, Hotwire::Response::ActiveRecordMixin