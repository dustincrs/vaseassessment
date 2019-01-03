class SearchController < ApplicationController

	def search
		all_results = PgSearch.multisearch(search_params["query"])
		r_questions = all_results.select {|e| e.searchable_type == "Question" }.map { |f| f.searchable_id }
		r_answers = all_results.select {|e| e.searchable_type == "Answer" }.map { |f| f.searchable_id }
		r_surveys = all_results.select {|e| e.searchable_type == "Survey" }.map { |f| f.searchable_id }

		#Handle answers
		r_answers.each do |answer|
			r_questions.push(Answer.find_by_id(answer).question.id)
		end

		#Handle surveys
		r_surveys.each do |s|
			survey = Survey.find_by_id(s)

			survey.questions.each do |question|
				r_questions.append(question.id)
			end
		end

		#Get unique questions (no repeats)
		all_questions = r_questions.uniq.map { |e| Question.find_by_id(e) }
		@results = all_questions.map { |e| [e, e.answers] }.to_json

		ActiveRecord::Base.include_root_in_json = false

		# @results = all_questions.map { |e| e.to_json }

		respond_to do |format|
			format.json {render json: @results}
		end

	end

	def search_params
		params.permit(:query)
	end
end
