class Question < ApplicationRecord
	include PgSearch

	#Associations
	has_many :answers
	belongs_to :survey

	#Searches
	multisearchable :against => [:text, :question_type]
end
