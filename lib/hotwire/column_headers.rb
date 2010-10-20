require 'active_support'

module Hotwire #:nodoc:
  
  ##
  # Represents header information for a Hotwire::Table
  #
  class ColumnHeaders
    
    ##
    # Initialize from a hash of data. See Hotwire::Table.initialize for param information.
    #
    def initialize data
      @data = data
    end
  
    ##
    # Convert to a Wire compatible Hash
    #
    def to_wire
      returning [] do |columns|
        @data[:columns].each_with_index do |column, index| 
          columns << {'id' => column, 'label' => column.humanize, 'type' => column_type_for_index(index)}
        end
      end
    end

  private
  
    ##
    # Determine the column data type by index 
    #
    def column_type_for_index index
      column_type(@data[:rows].first[index])
    end
    
    ##
    # Determine the column data type for a given value
    #
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