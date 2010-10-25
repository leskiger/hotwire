require 'set'
require 'csv'

module Hotwire
  class Base
    @@error_reasons = Set.new([
      :not_modified, :user_not_authenticated, :unknown_data_source_id, 
      :access_denied, :unsupported_query_operation, :invalid_query, 
      :invalid_request, :internal_error, :not_supported, 
      :illegal_formatting_patterns, :other
    ])
    attr_reader :errors
    
    def initialize *args
      @errors = []
    end
    
    # Checks whether this instance is valid (in terms of configuration parameters)
    # or not.
    def valid?
      validate
      @errors.size == 0
    end
    
    # Placeholder to be overwritten by subclasses
    def validate
    end

    # Manually adds a new validation error. +reason+ should be a symbol detailing
    # the cause of the errors and should be one of the +ERROR_REASONS+. 
    # +message+ is a short descriptive message, while +detailed_message+, if 
    # provided, can be a longer message that can include minimal html formatting
    # (anchor tags with a single href attribute).
    def add_error(reason, message, detailed_message=nil)
      unless @@error_reasons.include?(reason)
        raise ArgumentError.new("Invalid error reason: #{reason}")
      end
      error = {:reason => reason.to_s, :message => message}
      error[:detailed_message] = detailed_message if detailed_message
      @errors << error
      return self
    end
  end
end