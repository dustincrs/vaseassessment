class EditQuestionTable < ActiveRecord::Migration[5.2]
  def change
  	rename_column :questions, :type, :question_type
  	remove_column :questions, :title
  end
end
