class SetUserActiveToFalse < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :active, :boolean, default: false
  end
end
