class AddTitleAndBodyToContributions < ActiveRecord::Migration[5.2]
  def change
    add_column :contributions, :title, :string
    add_column :contributions, :body_html, :text
  end
end
