require 'test_helper'

class TestColumnHeaders < Test::Unit::TestCase
  context "a Hotwire::ColumnHeaders instance" do
    setup do
      time = Time.utc(2010, 10, 19, 9, 38, 10)
      @headers = Hotwire::ColumnHeaders.new({:columns => ['started at', 'name', 'years', 'location'], :rows => [[time, "bob", 21, nil]]})
    end
    
    context "to_wire" do
      should "return a propperly formatted array" do
        expected = [{"type"=>"datetime", "id"=>"started at", "label"=>"Started at"},
                    {"type"=>"string", "id"=>"name", "label"=>"Name"},
                    {"type"=>"number", "id"=>"years", "label"=>"Years"},
                    {"type"=>"string", "id"=>"location", "label"=>"Location"}]
        assert_equal expected, @headers.to_wire
      end
    end
  end
end
