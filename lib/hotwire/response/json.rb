module Hotwire
  module Response
    # Specialization responsible for producing responses in JSON format.
    class Json < Hotwire::Response::Base

      def initialize(request)
        super(request)
        @responseHandler = "google.visualization.Query.setResponse"
      end

      # Returns the datasource in JSON format. It supports the +responseHandler+
      # parameter. All the errors are returned with the +invalid_request+ key.
      # Warnings are unsupported (yet).
      def body
        rsp = {}
        rsp[:version] = @version
        rsp[:reqId] = @request[:reqId] if @request[:reqId]
        if valid?
          rsp[:status] = "ok"
          rsp[:table] = datatable unless data.nil?      
        else
          rsp[:status] = "error"
          rsp[:errors] = @errors
        end
        "#{@request[:responseHandler] || @responseHandler}(#{rsp.to_json})"   
      end

      # Renders the part of the JSON response that contains the dataset.
      def datatable
        dt = {}
        dt[:cols] = columns
        dt[:rows] = []
        data.each do |datarow|
          row = []
          datarow.each_with_index do |datacell, colnum|
            row << { :v => convert_cell(datacell, columns[colnum][:type])  }
          end
    
          dt[:rows] << { :c => row }
        end
        return dt
      end
      protected :datatable

      # Converts a value in the dataset into a format suitable for the 
      # column it belongs to. 
      #
      # Datasets are expected to play nice, and try to adhere to the columns they
      # intend to export as much as possible. This method doesn't do anything more
      # than the very minimum to ensure a formally valid wire export.
      def convert_cell(value, coltype)
        case coltype
        when "boolean"
          value ? 'true' : 'false'
        when "number"
          value
        when "string"
          value
        when "date"
          Hotwire::Response::Json::Date.new(value)
        when "datetime"
          Hotwire::Response::Json::DateTime.new(value)
        when "timeofday"
          [ value.hour, value.min, value.sec, value.usec / 1000 ]
        end
      end
      protected :convert_cell
      
      # Utility class to produce a JSON rendering of dates compatible with 
      # what the Wire APIs expect ( a Javascript date object )
      class Date  
        def initialize(date)
          @date = date
        end

        def to_json(options=nil)
          @date.nil? ? "" : "new Date(#{@date.year}, #{@date.month-1}, #{@date.day})"
        end
      end

      # Utility class to produce a JSON rendering of datetimes compatible with 
      # what the Wire APIs expect ( a Javascript date object )
      class DateTime
        def initialize(datetime)
          @datetime = datetime
        end

        def to_json(options=nil)
          @datetime.nil? ? "" : "new Date(#{@datetime.year}, #{@datetime.month-1}, #{@datetime.day}, #{@datetime.hour}, #{@datetime.min}, #{@datetime.sec})"
        end
      end

    end
    
  end
end