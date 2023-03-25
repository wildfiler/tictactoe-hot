# frozen_string_literal: true

class Game < ApplicationRecord
  enum state: { waiting: 0, active: 1, finished: 2, default: :waiting }

  scope :for_player, ->(player) { where(player_x: player.uuid).or(where(player_o: player.uuid)) }
  scope :for_player_x, ->(player) { where(player_x: player.uuid) }

  def players
    [player_x, player_o].compact
  end

  def symbol_for(player)
    if player_x == player.uuid
      'X'
    elsif player_o == player.uuid
      'O'
    else
      raise UnknownPlayer.new('Unknown player for game', self, player)
    end
  end
end
