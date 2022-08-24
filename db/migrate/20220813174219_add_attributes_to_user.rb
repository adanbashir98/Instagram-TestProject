# frozen_string_literal: true

class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :full_name, :string
    add_column :users, :bio, :text
  end
end
