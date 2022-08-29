# frozen_string_literal: true

class AddAttributesToUser < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.add_column :users, :full_name, :string, null: false, default: ''
      t.add_column :users, :bio, :text
    end
  end
end
