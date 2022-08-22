# frozen_string_literal: true

class DropPost < ActiveRecord::Migration[5.2]
  def up
    drop_table :posts
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
