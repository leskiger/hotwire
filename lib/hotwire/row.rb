module Hotwire
  class Row
    def initialize data
      @data = data
    end
  
    def to_wire
      { 'c' => @data.map { |value| {'v' => format_value(value) } } }
    end

  private
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
    
    def format_date value
      #times pulled from an attribute hash are not converted to the zone automatically
      value = value.in_time_zone if Time.respond_to?(:zone) and Time.zone and value.respond_to?(:in_time_zone)
      #google expects a 0 based month
      "Date(#{value.year}, #{value.month - 1}, #{value.day}, #{value.hour}, #{value.min}, #{value.sec})"
    end
  end
end