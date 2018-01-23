require 'test_helper'
 
class CodeAnalyzerTest < ActiveSupport::TestCase
  test 'initializing CodeAnalyzer adds counting code to submitted code' do
    code_analyzer = CodeAnalyzer.new('x = 1')
    assert_equal "count = 0\nx = 1\ncount += 1\ncount", code_analyzer.code
  end

  test 'initializing CodeAnalyzer creates empty graph_data array' do
    code_analyzer = CodeAnalyzer.new('x = 1')
    assert_equal [], code_analyzer.graph_data
  end

  test '#run_code - returning of evaluation of code' do
    code_analyzer = CodeAnalyzer.new
    assert_equal 2, code_analyzer.run_code('1 + 1')
  end

  test '#run_code - return error message when evaluating code with runtime error' do
    code_analyzer = CodeAnalyzer.new
    assert_equal "Error: Code doesn't run!", code_analyzer.run_code('x')
  end

  test '#results - returns complete graph data' do
    code_analyzer = CodeAnalyzer.new("[*].each do |number|\nnumber\nend")
    assert_equal [{x: 100, y: 201}, {x: 500, y: 1001}, {x: 1000, y: 2001}, {x: 1500, y: 3001}, {x: 2000, y: 4001}, {x: 2500, y: 5001}, {x: 3000, y: 6001}], code_analyzer.results
  end

  test '#skip_comment - returns code that does not include commented lines as significant steps' do 
    code_analyzer = CodeAnalyzer.new("[9, 3, 1, 7, 3, 1, 6].each do |number|\nsum += number\n#testing\nend") 
    line_count = code_analyzer.code.lines.count
    result = code_analyzer.skip_comment.lines.count
    assert_equal(result, line_count - 1)
    refute_includes(code_analyzer.skip_comment, '#testing') 
  end 

  test '#skip_comment - returns code that does not include comments at the end of lines' do 
    code_analyzer = CodeAnalyzer.new("[9, 3, 1, 7, 3, 1, 6].each do |number|\nsum += number #testing\nend") 
    line_count = code_analyzer.code.lines.count
    result = code_analyzer.skip_comment.lines.count
    assert_equal(result, line_count)
    refute_includes(code_analyzer.skip_comment, '#testing')  
  end

  test '#skip_comment - removes comment lines that with leading wihte space' do 
    code_analyzer = CodeAnalyzer.new("[9, 3, 1, 7, 3, 1, 6].each do |number|\nsum += number\n  #testing\nend") 
    line_count = code_analyzer.code.lines.count
    result = code_analyzer.skip_comment.lines.count
    assert_equal(result, line_count - 1)
    refute_includes(code_analyzer.skip_comment, '#testing') 
  end   
end



