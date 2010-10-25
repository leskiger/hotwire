module Hotwire
  module Response
    
    # This mixin adds the ability to pass an ActiveRecord model to add_columns
    module ActiveRecordMixin
      def add_columns_with_active_record_model(args)
        if args.respond_to?(:ancestors) and args.ancestors.include? ActiveRecord::Base
          args = args.columns.map do |col| 
            [normalize_active_record_type(col.type), {:id => col.name, :label => col.name }]
          end
        end
        add_columns_without_active_record_model(args) 
        
      end
      
      def self.included(base)
        base.send :alias_method_chain, :add_columns, :active_record_model
      end
      
    private
      
      # Convert an ActiveRecord type string to Wire Protocol types
      def normalize_active_record_type(type)
        case type
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