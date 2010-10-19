require 'active_support'

module Hotwire
  class ColumnHeaders
    def initialize data
      @data = data
    end
  
    def to_wire
      returning [] do |columns|
        @data[:columns].each_with_index do |column, index| 
          columns << {'id' => column, 'label' => column.humanize, 'type' => column_type_for_index(index)}
        end
      end
    end

  private
  
    def column_type_for_index index
      column_type(@data[:rows].first[index])
    end
    
    def column_type sample_value
      case sample_value.class.name
      when 'BigDecimal', 'Fixnum'
        'number'
      when /Time/
        'datetime'
      when 'String'
        'string'
      else
        'string'
      end
    end

  end
end