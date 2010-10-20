module Hotwire #:nodoc:
  
  ##
  # Represents a one-dimensional row of data.
  #
  class Row
    
    ##
    # Construct a new Row object from a array of data.
    #
    def initialize data
      raise ArgumentError, "data must be an Array of values" unless data.is_a?(Array)
      @data = data
    end
  
    ##
    # Convert the row to a Wire compatible Hash
    #
    def to_wire
      { 'c' => @data.map { |value| {'v' => format_value(value) } } }
    end

  private
  
    ##
    # Perform any formatting needed to make value Wire compatible.
    #
    def format_value value
      case value.class.name
      when /Time/
        format_date value
      when /NilClass/
        0
      else
        value
      end
    end
    
    ##
    # Wire dates seem to expect to have 0 based month.
    #
    def format_date value
      "Date(#{value.year}, #{value.month - 1}, #{value.day}, #{value.hour}, #{value.min}, #{value.sec})"
    end
  end
end