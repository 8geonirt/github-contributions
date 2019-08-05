class ChangeUserIdTypeInContributions < ActiveRecord::Migration[5.2]
  def up
    change_column :contributions, :user_id, 'integer USING CAST(user_id AS integer)'
  end

  def down
    change_column :contributions, :user_id, :string
  end
end
