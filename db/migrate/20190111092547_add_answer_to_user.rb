class AddAnswerToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :answer, foreign_key: true
  end
end
