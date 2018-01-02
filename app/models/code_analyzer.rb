class CodeAnalyzer
  
  def initialize(code='')
    @code = code
    add_counters_to_code!
    @graph_data = []
  end

  def results
    if @code.index("[*]")
      [100, 500, 1000, 1500, 2000, 2500, 3000].each do |data|
        @graph_data << {x: data, y: run_code(@code.gsub("[*]", "#{(1..data).to_a}"))}
      end
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