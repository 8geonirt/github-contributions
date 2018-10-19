class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false, default: ''
      t.string :url, null: false, default: ''
      t.datetime :project_created_at
      t.datetime :project_last_modified
      t.timestamps null: false
    end
  end
end
