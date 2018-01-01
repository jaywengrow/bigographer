class CodeAnalyzer
  
  def initialize(code='')
    @code = code
    add_counters_to_code!
    @results = []
  end

  def results
    return number_of_steps
  end

  private

  def number_of_steps
    begin
      return eval(@code)
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