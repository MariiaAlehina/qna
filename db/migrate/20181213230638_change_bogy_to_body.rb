class ChangeBogyToBody < ActiveRecord::Migration[5.2]
  def change
    rename_column :answers, :bogy, :body
  end
end
