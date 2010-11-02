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
      
      context "add_columns" do
        setup { @response.add_columns([['string', {:id => 'Column A'}], ['number', {:id => 'Column B'}]]) }
        
        should "add each column passed in" do
          expected = [{:type=>"string", :id=>"Column A"}, {:type=>"number", :id=>"Column B"}]
          assert_equal expected, @response.columns
        end
      end
      
      context "set_data" do
        context "from an array of hashes" do
          context "when columns are not set" do
            setup do
              @datetime = Time.utc(2010, 11, 2, 9, 35, 00)
              @data = [{'string_col' => 'a1', 'int_col' => 2, 'decimal_col' => 3.3, 'datetime_col' => @datetime}]
              @response.set_data(@data)
            end
            should "add columns to the response" do
              expected = [{:id => 'datetime_col', :label => "datetime_col", :type => 'datetime'},
                          {:id => 'decimal_col', :label => "decimal_col", :type => 'number'},
                          {:id => 'int_col', :label => "int_col", :type => 'number'},
                          {:id => 'string_col', :label => "string_col", :type => 'string'}]
              assert_equal expected, @response.columns
            end
            should "set the data for the response" do
              assert_equal [[@datetime, 3.3, 2, 'a1']], @response.data
            end
          end
          
          context "when columns are already set" do
            setup do
              @data = [{'col_a' => 'a1', 'col_b' => 'b1', 'col_c' => 'c1'}]
              @response.add_columns([['string', {:id => 'col_c', :label => 'col_c'}],
                                     ['string', {:id => 'col_a', :label => 'col_a'}]])
              @response.set_data(@data)
            end
            should "add columns to the response" do
              expected = [{:id => 'col_c', :label => "col_c", :type => 'string'},
                          {:id => 'col_a', :label => "col_a", :type => 'string'}]
              assert_equal expected, @response.columns
            end
            should "set the data for the response" do
              assert_equal [['c1', 'a1']], @response.data
            end
          end
        end
        
        context "from a :rows, :columns hash" do
          setup do
            @datetime = Time.utc(2010, 11, 2, 9, 35, 00)
            @data = {:columns => ["string_col", "int_col", "decimal_col", "datetime_col"],
                     :rows => [['a1', 2, 3.3, @datetime]]}
            @response.set_data(@data)
          end
          
          should "add columns to the response" do
            expected = [{:id => 'string_col', :label => "string_col", :type => 'string'},
                        {:id => 'int_col', :label => "int_col", :type => 'number'},
                        {:id => 'decimal_col', :label => "decimal_col", :type => 'number'},
                        {:id => 'datetime_col', :label => "datetime_col", :type => 'datetime'}]
            assert_equal expected, @response.columns
          end
          
          should "set the data from the response" do
            assert_equal [['a1', 2, 3.3, @datetime]], @response.data
          end
        end
        
        context "from an array of arrays" do
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
end
