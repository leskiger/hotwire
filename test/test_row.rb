require 'test_helper'

class TestRow < Test::Unit::TestCase
  context "a Hotwire::Row instance" do
    setup do
      time = Time.local(2010, 10, 19, 9, 38, 10)
      @row = Hotwire::Row.new([time, "value1", nil])
    end
    
    context "to_wire" do
      should "return a propperly formatted hash" do
        expected = { 'c' => [{ 'v' => "Date(2010, 9, 19, 9, 38, 10)" }, { 'v' => "value1" }, { 'v' => 0 } ] }
        assert_equal expected, @row.to_wire
      end
    end
  end
end
