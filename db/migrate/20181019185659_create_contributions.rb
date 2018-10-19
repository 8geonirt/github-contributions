class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.string :repository, null: false, default: ''
      t.string :pull_request_url, null: false, default: ''
      t.string :author, null: false, default: ''
      t.datetime :closed_merged_at
    end
  end
end
