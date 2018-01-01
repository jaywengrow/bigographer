class CodeAnalyzer
  
  def initialize(code='')
    @code = code
    add_counters_to_code!
    @graph_data = {}
  end

  def results
    if @code.index("[*]")
      @graph_data[1] = run_code(@code.gsub("[*]", "[1]"))
      @graph_data[2] = run_code(@code.gsub("[*]", "[1, 2]"))
      @graph_data[3] = run_code(@code.gsub("[*]", "[1, 2, 3]"))
    else
      @graph_data = {1 => run_code(@code)}
    end

    return @graph_data
  end

  private

  def run_code(code)
    begin
      return eval(code)
    rescue
      return "Error: Code doesn't run!"
    end
  end

  def add_counters_to_code!
    new_code = "count = 0\n"
    @code.each_line do |line|
      new_code += "#{line}\n"
      new_code += "count += 1\n"
    end
    new_code += "count"
    @code = new_code
  end

end