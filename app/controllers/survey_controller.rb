require "active_support/core_ext/object/blank"

class SurveyController < ApplicationController

	def create
		# Get the RAW data in as JSON
		survey_data = JSON.parse(survey_params[:qsf_file].read)

		# Make the survey object first...
		# Extracting the data necessary first...
		survey_title = survey_data["SurveyEntry"]["SurveyName"]
		new_survey = Survey.new(title: survey_title)
		if(new_survey.save)
			p "Successfully saved survey!"
		else
			p "Error saving survey!"
		end

		# Now make the question object...
		all_questions = survey_data["SurveyElements"].select {|x| x["Element"]== "SQ"}

		# Make each question
		all_questions.each do |question|
			question_type = question["Payload"]["QuestionType"]
			question_text = ActionController::Base.helpers.strip_tags(question["Payload"]["QuestionText"]).gsub("\n", "")
			new_question = new_survey.questions.build(text: question_text, question_type: question_type)

			if(new_question.save)
				# If successfully saved, start making the answers...
				p "Saved question"
				question_choices = question["Payload"]["Choices"]
				
				if question_choices.blank?
					# No need to create answer object
					p "Question has no options! (Need to enter text)"
				else
					# Create answer object(s)
					p "Working on question #{new_question.id}"
					question_choices = question_choices.values.map {|v| v["Display"]}
					question_choices.each do |choice|
						new_answer = new_question.answers.build(text: choice)

						if(new_answer.save)
							p "Answer saved!"
						else
							p "Failed to save answer!"
						end
					end
				end
			else
				p "Error saving question"
			end
		end
	end

	def survey_params
		params.permit(:qsf_file)
	end

end
