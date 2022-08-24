# frozen_string_literal: true

class AddIndexToFollow < ActiveRecord::Migration[5.2]
  def change
    add_index :follows, %i[follower_id followee_id], unique: true
  end
end
