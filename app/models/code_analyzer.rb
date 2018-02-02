class CodeAnalyzer

  attr_reader :codes, :graphs_data
  
  def initialize(code='')
    @codes = code.split(',')
    add_counters_to_code!
    @graphs_data = Array.new(@codes.length) { Array.new }
  end

  # The 'results' method is the brains behind the time complexity analysis.
  # It looks to see whether the code contains [*], in which case the user is indicating 
  # that they want to test multiple size arrays with the given algorithm.
  # The method then runs the submitted code with various size arrays, ranging from 100 up to 3000.
  # The data is saved as an array of x, y coordinates. x indicates the amount of data,
  # and y indicates the number of steps it takes for the code to actually run.

  def results
    @codes.each_with_index do |code, i|
      if code.index("[*]")
        [100, 500, 1000, 1500, 2000, 2500, 3000].each do |data|
          @graphs_data[i] << {x: data, y: run_code(code.gsub("[*]", "#{(1..data).to_a}"))}
        end
      end
    end
    return @graphs_data
  end


  # With the 'run_code' method, we attempt to run the code and handle errors if they arise. This doesn't properly handle syntax
  # errors, so will need some further work.

  def run_code(code)
    begin
      return eval(code)
    rescue
      return "Error: Code doesn't run!"
    end
  end

  private
  # The 'add_counters_to_code!' method implements our counting of the code's steps. We follow
  # a simplistic algorithm, and that is to set a 'count' variable before the code begins, and then
  # increment count after each line of code runs.

  def add_counters_to_code!
    @codes.map! do |code|
      new_code = "count = 0\n"
      code.each_line do |line|
        new_code += "#{line}\n"
        new_code += "count += 1\n"
      end
      new_code += "count"
    end
  end
end