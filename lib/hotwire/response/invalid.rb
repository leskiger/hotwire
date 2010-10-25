module Hotwire
  module Response
    # Represents an invalid set of parameters. This is used only to guarantee
    # a return value from the factory methods, even when parameters are wrong.
    #
    # Invoking +valid?+ on this class will sistematically return +false+. 
    class Invalid < Hotwire::Response::Base
      def initialize(request)
        super(request)
        add_error(:invalid_request, 
                  "Invalid output format: #{request[:out]}. " +
                  "Valid ones are json,csv,html")
      end
    end
  end
end