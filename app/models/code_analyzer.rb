class CodeAnalyzer
  
  def initialize(code='')
    @code = code
  end

  def number_of_steps
    new_code = "count = 0\n"
    @code.each_line do |line|
      new_code += "#{line}\n"
      new_code += "count += 1\n"
    end
    new_code += "count"
    begin
      return eval(new_code)
    rescue
      return "Error: Code doesn't run!"
    end
  end

end