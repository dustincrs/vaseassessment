class Survey < ApplicationRecord
	include PgSearch

	#Associations
	has_many :questions

	#Searches
	multisearchable :against => [:title]
end
