class Answer < ApplicationRecord
	include PgSearch

	#Associations
	belongs_to :question

	#Search
	multisearchable :against => [:text]

end
