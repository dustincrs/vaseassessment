class FileController < ApplicationController
  def download
  	output = []

  	file_params["ids"].each do |q_id|
  		question = Question.find_by_id(q_id)

  		text = "#{question.question_type} : #{question.text} \n"

  		question.answers.each do |answer|
  			text += "#{answer.text}\n"
  		end

  		output << text
  	end

  	output = output.join("\n")
  	send_data(output, filename: 'pocket.txt', disposition: 'attachment')
  end

  def file_params
  	params.permit(ids: [])
  end
end
