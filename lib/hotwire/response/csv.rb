module Hotwire
  module Response
    # Specialization responsible for producing responses in CSV format.
    class Csv < Hotwire::Response::Base
      def body
        rsp = []
        CSV::Writer.generate(rsp) do |csv|
          csv << columns.map { |col| col[:label] || col[:id] || col[:type] }
          data.each do |datarow|
            csv << datarow
          end
        end
        return rsp.join
      end
    end
  end
end