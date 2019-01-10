class AddAnswersToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :answers, :user_id, :integer, index: true
  end
end

