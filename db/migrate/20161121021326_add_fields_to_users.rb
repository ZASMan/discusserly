class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :about_me, :text
    add_column :users, :location, :string
    add_column :users, :image_url, :string
  end
end
