class Api::V1::CodesController < ApplicationController
  def analyze
    code = params[:code]
    new_code = "count = 0\n"
    code.each_line do |line|
      new_code += "#{line}\n"
      new_code += "count += 1\n"
    end
    code += "count"
    number_of_steps = eval(new_code)
    render json: {count: number_of_steps}
  end
end
