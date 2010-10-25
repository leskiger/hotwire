module Hotwire
  class Request < Hotwire::Base
    
    # Factory method to create a Request instance from the request parameters.
    # +tqx:out+ is used to determine the specific class instance returned
    # by this method, depending on the requested output format.
    def self.from_params(params)
      # Exract Wire params from the request.
      wire_params = {}
      tqx = params[:tqx]
      return false if not tqx or tqx.blank?
      
      wire_params[:tqx] = true
      tqx.split(';').each do |kv|
        key, value = kv.split(':')
        wire_params[key.to_sym] = value
      end
    
      # Create the appropriate Wire instance from the gviz-specific parameters
      wire_params[:out] ||= "json"    
      self.new(wire_params)
    end 
  
    # Creates a new instance and validates it. 
    def initialize(wire_params)
      super
      @params = wire_params
    end
    protected :initialize
    
    # Builds a new response object from the request
    def build_response
      Hotwire::Response.from_request(self)
    end
    
    # Validates this instance by checking that the configuration parameters
    # conform to the official specs.
    def validate
      @errors.clear
      if @params[:tqx]
        add_error(:invalid_request, 
                  "Missing required parameter reqId") unless @params[:reqId]
      
        if @params[:version] && !Hotwire.supported_api_versions.include?(@params[:version])
          add_error(:invalid_request, "Unsupported version #{@params[:version]}")
        end
      end
    end
    
    # Access a Wire parameter. +k+ must be symbols, like +:out+, +:reqId+.
    def [](k)
      @params[k]
    end
  
    # Sets a Wire parameter. +k+ must be symbols, like +:out+, +:reqId+.
    def []=(k, v)
      @params[k] = v
    end
  end
end