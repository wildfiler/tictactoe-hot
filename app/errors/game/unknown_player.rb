# frozen_string_literal: true

class Game
  class UnknownPlayer < StandardError
    attr_reader :game, :player

    def initialize(msg, game, player)
      @game = game
      @player = player
      super("#{msg} (player: #{player.uuid}, expecting: [#{game.players.join(', ')}]")
    end
  end
end
