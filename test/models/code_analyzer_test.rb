require 'test_helper'
 
class CodeAnalyzerTest < ActiveSupport::TestCase
  test '#run_code - returning of evaluation of code' do
    code_analyzer = CodeAnalyzer.new
    assert_equal 2, code_analyzer.run_code('1 + 1')
  end

  test '#run_code - return error message when evaluating code with runtime error' do
    code_analyzer = CodeAnalyzer.new
    assert_equal "Error: Code doesn't run!", code_analyzer.run_code('x')
  end

  test '#run_code - return error message when evaluating code with syntax error' do
    skip
    code_analyzer = CodeAnalyzer.new
    assert_equal "Error: Code doesn't run!", code_analyzer.run_code('if')
  end
end