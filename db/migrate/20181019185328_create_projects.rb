class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :url
      t.datetime :project_created_at
      t.datetime :project_last_modified
      t.timestamps
    end
  end
end
