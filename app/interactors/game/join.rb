# frozen_string_literal: true

class Game
  class Join
    attr_reader :player

    def initialize(player)
      @player = player
    end

    def call
      waiting_player_game || active_game || waiting_game || new_game
    end

    private

    def waiting_player_game
      Game.waiting.where(player_x: player.uuid).first
    end

    def active_game
      Game.active.for_player(player).first
    end

    def waiting_game
      activate_available_game
      active_game
    end

    def new_game
      Game.create!(player_x: player.uuid)
    end

    def waiting_games
      Game.waiting
          .where.not(player_x: player.uuid)
          .order(:created_at)
    end

    # rubocop:disable Rails/SkipsModelValidations
    def activate_available_game
      waiting_games.limit(1).update_all(
        player_o: player.uuid,
        state: :active,
        updated_at: Time.current,
      )
    end
    # rubocop:enable Rails/SkipsModelValidations
  end
end
