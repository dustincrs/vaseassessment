class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
    	t.string		:title
    	t.string 		:text
    	t.string		:type

    	t.integer		:survey_id
		t.timestamps
    end
  end
end
