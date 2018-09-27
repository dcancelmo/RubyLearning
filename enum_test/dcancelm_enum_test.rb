require 'minitest/autorun'
require './TestArray.rb'

class TestEnumTests < Minitest::Test
    def test_collect
        bool_array = TestArray.new([true, false, false])
        str_array = TestArray.new(["hello", "world!", "asdfghjklqwerty", "world"])
        assert_equal bool_array.custom_collect{|i| i.to_s}.to_a, ["true", "false", "false"]
        assert_equal str_array.custom_collect{|i| i.length}.to_a, [5, 6, 15, 5]
        assert_equal bool_array.custom_collect{|i| !i }.to_a, [false, true, true]
    end

    def test_inject
        array = TestArray.new([5, 6, 7, 8, 9, 10])
        assert_equal array.custom_inject(0) {|sum, n| sum + n }, 45
        assert_equal array.custom_inject(1) {|sum, n| sum * n }, 151200
        assert_equal array.custom_inject {|sum, n| sum - n }, -45
    end

    def test_select
        array = TestArray.new([1,2,3,4,5,6,7,8,9,10])
        str_array = TestArray.new(["hello", "world", "asdfghjklqwerty", "world"])
        assert_equal array.custom_select {|x| x <= 5}.to_a, [1, 2, 3, 4, 5]
        assert_equal str_array.custom_select {|x| x.length > 8}.to_a, ["asdfghjklqwerty"]
        assert_equal str_array.custom_select {|x| x == "world"}.to_a, ["world", "world"]

    end

    def test_max
        array1 = TestArray.new([-5,2,3,4,34,6,7,8,284,9])
        array2 = TestArray.new([-5,-2,-3,-4,-34,-6,-7,-8,-284,-9])
        str_array = TestArray.new(["hello", "world", "asdfghjklqwerty", "world"])

        assert_equal array1.custom_max, 284
        assert_equal array2.custom_max {|a,b| a <=> b}, -2
        assert_equal str_array.custom_max {|a,b| a.length <=> b.length}, "asdfghjklqwerty"
    end

    def test_max_by
        bool_array = TestArray.new([true, false, false])
        str_array = TestArray.new(["hello", "world", "asdfghjklqwerty", "world"])
        int_array = TestArray.new([-5,2,3,4,34,6,7,8,284,9])
        assert_equal str_array.custom_max_by {|x| x.length}, "asdfghjklqwerty"
        assert_equal bool_array.custom_max_by {|x| x.to_s.length}, false
        assert_equal int_array.custom_max_by {|a| a}, 284
    end
end

