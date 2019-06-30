class AddUpdatedAtToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :contribution_updated_at, :timestamp
  end
end
