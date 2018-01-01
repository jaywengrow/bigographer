class Api::V1::CodesController < ApplicationController
  def analyze
    code_analyzer = CodeAnalyzer.new(params[:code])
    
    render json: {count: code_analyzer.number_of_steps}
  end
end
