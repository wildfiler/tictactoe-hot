# frozen_string_literal: true

class Game
  class BroadcastUpdate
    attr_reader :game

    def initialize(game)
      @game = game
    end

    def call
      players_uuids.each do |player_uuid|
        broadcast_to(Player.new(uuid: player_uuid))
      end
    end

    private

    def broadcast_to(player)
      Turbo::StreamsChannel.broadcast_update_to(
        game, player.uuid,
        target: game_dom_id,
        partial: game,
        locals: { game:, player: },
      )
    end

    def players_uuids
      game.players
    end

    def game_dom_id
      ActionView::RecordIdentifier.dom_id(game)
    end
  end
end
