class AddQuestionsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :user_id, :integer, index: true
  end
end
