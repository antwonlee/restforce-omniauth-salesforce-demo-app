class ChangeStringsIntoTextToUser < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :oauth_token, :text
    change_column :users, :refresh_token, :text
  end
end
