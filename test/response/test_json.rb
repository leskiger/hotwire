require 'test_helper'

class TestResponseJson < Test::Unit::TestCase
  context "the Hotwire::Response::Json instance" do
    
    context "created from a valid request" do
      setup { @response = Hotwire::Response.from_request(valid_request(:out => 'json')) }
      
      context "with valid data" do
        setup do
          @response.add_column("string", :label => "Column A")
          @response.set_data([["a1"]])
        end
        
        context "body" do
          should "return valid wire json, wrapped in the response handler" do
            assert_match /^google.visualization.Query.setResponse\(\{.+\}\)$/, @response.body
            assert_match /\"table\":\{.+\}/, @response.body
            assert_match /\"rows\":\[\{\"c\":\[\{\"v\":\"a1\"\}\]\}\]/, @response.body
            assert_match /\"cols\":\[\{\"type\":\"string\",\"label\":\"Column A\"\}\]/, @response.body
            assert_match /\"status\":\"ok\"/, @response.body
          end
        end
      end
    end
  end
  
  context "a Hotwire::Response::Json::DateTime instance" do
    context "created with ni" do
      setup do
        @datetime = Hotwire::Response::Json::DateTime.new(nil)
      end
      
      should "return a blank string" do
        assert_equal "", @datetime.to_json
      end
    end
  end
  
  context "a Hotwire::Response::Json::Date instance" do
    context "created with ni" do
      setup do
        @date = Hotwire::Response::Json::Date.new(nil)
      end
      
      should "return a blank string" do
        assert_equal "", @date.to_json
      end
    end
  end
end
