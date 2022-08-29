# frozen_string_literal: true

class AddIndexToLike < ActiveRecord::Migration[5.2]
  def change
    remove_index :likes, :post_id
    add_index :likes, %i[post_id user_id], unique: true
  end
end
