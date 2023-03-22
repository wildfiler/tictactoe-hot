# frozen_string_literal: true

class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :player_x
      t.string :player_o
      t.integer :state, null: false, default: 0

      t.timestamps

      t.index :player_x
      t.index :player_o
    end
  end
end
