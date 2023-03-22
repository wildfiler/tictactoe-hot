# frozen_string_literal: true

class Game
  class Join
    attr_reader :player

    def initialize(player)
      @player = player
    end

    def call
      active_game || waiting_game || new_game
    end

    private

    def active_game
      Game.active.for_player(player).first
    end

    def waiting_game
      Game.waiting.order(:created_at).first.tap do |game|
        break if game.blank?

        game.update!(player_o: player.uuid, state: :active)
      end
    end

    def new_game
      Game.create!(player_x: player.uuid)
    end
  end
end
