require 'test_helper'

class CodeAnalyzerTest < ActiveSupport::TestCase
  test 'initializing CodeAnalyzer adds counting code to submitted code' do
    analyzer = CodeAnalyzer.new('x = 1')
    assert_equal "count = 0\nx = 1\ncount += 1\ncount", analyzer.code
  end

  test 'initializing CodeAnalyzer creates empty graph_data array' do
    analyzer = CodeAnalyzer.new('x = 1')
    assert_equal [], analyzer.graph_data
  end

  test '#run_code - returning of evaluation of code' do
    analyzer = CodeAnalyzer.new
    assert_equal 2, analyzer.run_code('1 + 1')
  end

  test '#run_code - return error message when evaluating code with runtime error' do
    analyzer = CodeAnalyzer.new
    assert_equal "Error: Code doesn't run!", analyzer.run_code('x')
  end

  test '#results - returns complete graph data' do
    analyzer = CodeAnalyzer.new("[*].each do |number|\nnumber\nend")
    assert_equal [{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}], analyzer.results
  end

  test '#run_code - returns code that skips comments' do
    analyzer = CodeAnalyzer.new("[9, 3, 1].each do |number|\nsum += number\n#random comment here\nend\n=begin\n=end")
    assert_equal analyzer.code, "count = 0\n[9, 3, 1].each do |number|\n\ncount += 1\nsum += number\n\ncount += 1\nend\n\ncount += 1\ncount"
  end

  test '#run_code - returns code that does not skip an in line comment' do
    analyzer = CodeAnalyzer.new("[9, 3, 1].each do |number|\nsum += number #ARRRRRRRRRRRR\nend")
    assert_equal analyzer.code, "count = 0\n[9, 3, 1].each do |number|\n\ncount += 1\nsum += number #ARRRRRRRRRRRR\n\ncount += 1\nend\ncount += 1\ncount"
    
  end
end
