class RenameContributionsField < ActiveRecord::Migration[5.2]
  def change
    rename_column :contributions, :author, :user_id
  end
end
