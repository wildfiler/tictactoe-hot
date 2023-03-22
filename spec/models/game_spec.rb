# frozen_string_literal: true

require 'rails_helper'

describe Game do
  describe '.symbol_for' do
    it 'returns X for player_x' do
      player_x = build(:player)
      game = build(:game, player_x: player_x.uuid)

      expect(game.symbol_for(player_x)).to eq('X')
    end

    it 'returns O for player_o' do
      player_o = build(:player)
      game = build(:game, player_o: player_o.uuid)

      expect(game.symbol_for(player_o)).to eq('O')
    end

    context 'when unknown player' do
      it 'raises error' do
        player = build(:player)
        game = build(:game)

        expect do
          game.symbol_for(player)
        end.to raise_error(Game::UnknownPlayer) { |error| expect(error).to have_attributes(game:, player:) }
      end
    end
  end

  describe '.players' do
    it 'returns players uuids' do
      game = build(:game, :with_players)

      expect(game.players).to contain_exactly(game.player_x, game.player_o)
    end

    context 'when one player' do
      it 'returns player_x' do
        player = build(:player)
        game = build(:game, player_x: player.uuid)

        expect(game.players).to contain_exactly(player.uuid)
      end
    end
  end
end
