class ChangeBogyToBodyInQuestion < ActiveRecord::Migration[5.2]
  def change
    rename_column :questions, :bogy, :body
  end
end
