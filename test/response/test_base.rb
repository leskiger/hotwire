require 'test_helper'

class TestResponseBase < Test::Unit::TestCase
  context "the Hotwire::Response::Base instance" do
    
    context "created from a valid request" do
      setup { @response = Hotwire::Response::Base.new(valid_request) }
      
      context "add_col" do
        context "with a valid type" do
          setup { @response.add_column("string", :id => "col_a", :label => "Col A", :invalid_attr => "invalid")}
          
          should "add to the colums array" do
            assert_equal({:type => "string", :id => "col_a", :label => "Col A"}, @response.columns.first)
          end
          
          should "strip invalid attributes" do
            assert !@response.columns.first.has_key?(:invalid_attr)
          end
        end
        
        context "with an invalid type" do
          should "raise an ArgumetError" do
            assert_raises ArgumentError do
              @response.add_col("invalid_type")
            end
          end
        end
        
      end
      
      context "set_data" do
        setup do
          @data = [['a', 'b']]
          @response.set_data(@data)
        end
        
        should "set the data for the response" do
          assert_equal @data, @response.data
        end
      end
      
    end

  end
end
