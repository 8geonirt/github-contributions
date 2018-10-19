class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.string :repository
      t.string :pull_request_url
      t.string :author
      t.datetime :closed_merged_at
    end
  end
end
