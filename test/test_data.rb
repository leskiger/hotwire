require 'test_helper'

class TestData < Test::Unit::TestCase
  context "inializing from a Hash" do
    
    should "raise an ArgumentError if :columns are not specified" do
      assert_raise ArgumentError do
        Hotwire::Data.new({:rows => []})
      end
    end
    
    should "raise an ArgumentError if :rows are not specified" do
      assert_raise ArgumentError do
        Hotwire::Data.new({:columns => []})
      end
    end
    
  end
  
  context "a Hotwire::Date instance" do
    setup do
      time = Time.local(2010, 10, 19, 9, 38, 10)
      @data = Hotwire::Data.new({:columns => ['started at', 'name', 'years', 'location'], :rows => [[time, "bob", 21, nil]]})
    end
    
    context "to_wire" do
      should "return a properly formatted hash" do
        expected = { "table"=> { "rows"=> [ {"c"=> [{"v"=>"Date(2010, 9, 19, 9, 38, 10)"},
                                                    {"v"=>"bob"},
                                                    {"v"=>21},
                                                    {"v"=>0}]}],
                                 "cols"=> [{"type"=>"datetime", "id"=>"started at", "label"=>"Started at"},
                                           {"type"=>"string", "id"=>"name", "label"=>"Name"},
                                           {"type"=>"number", "id"=>"years", "label"=>"Years"},
                                           {"type"=>"string", "id"=>"location", "label"=>"Location"}]}}
        assert_equal expected, @data.to_wire
      end
    end
  end
end
