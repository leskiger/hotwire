module Hotwire
  module Response
    # Factory method to create a Hotwire::Response instance from a Hotwire::Request
    # object
    def self.from_request(request)
      case request[:out]
      when "json"
        Hotwire::Response::Json.new(request)
      when "html"
        Hotwire::Response::Html.new(request)
      when "csv"
        Hotwire::Response::Csv.new(request)
      else
        Hotwire::Response::Invalid.new(request)
      end
    end
  end
end