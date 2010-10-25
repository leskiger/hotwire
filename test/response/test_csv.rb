require 'test_helper'

class TestResponseCsv < Test::Unit::TestCase
  context "the Hotwire::Response::Csv instance" do
    
    context "created from a valid request" do
      setup { @response = Hotwire::Response.from_request(valid_request(:out => 'csv')) }
      
      context "with valid data" do
        setup do
          @response.add_column("string", :label => "Column A")
          @response.set_data([["a1"]])
        end
        
        context "body" do
          should "return csv" do
            expected = "Column A\na1\n"
            assert_equal expected, @response.body
          end
        end
      end
      
    end

  end
  
end
