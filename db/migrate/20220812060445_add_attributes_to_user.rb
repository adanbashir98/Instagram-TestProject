# frozen_string_literal: true

# Adding Attributes to Users
class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :full_name, :string, null: false
    add_column :users, :username, :string, null: false
    add_column :users, :bio, :text
  end
end
