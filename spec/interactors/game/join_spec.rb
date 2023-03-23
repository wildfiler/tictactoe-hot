# frozen_string_literal: true

require 'rails_helper'

describe Game::Join do
  it 'creates new game' do
    player = build(:player)

    expect do
      described_class.new(player).call
    end.to change(Game, :count).by(1)
  end

  it 'sets correct attributes for new game' do
    player = build(:player)

    game = described_class.new(player).call

    expect(game).to have_attributes(
      player_x: player.uuid,
      state: 'waiting',
    )
  end

  context 'when waiting game for player exists' do
    it 'returns correct game' do
      player = build(:player)
      game = create(:game, :waiting, player_x: player.uuid)

      result_game = described_class.new(player).call

      expect(result_game).to eq(game)
    end

    it 'does not change state' do
      player = build(:player)
      game = create(:game, :waiting, player_x: player.uuid)

      expect do
        described_class.new(player).call
      end.not_to(change { game.reload.state })
    end
  end

  context 'when active game for player exists' do
    context 'when player_x' do
      it 'returns correct game' do
        player = build(:player)
        game = create(:game, :with_players, player_x: player.uuid)

        result_game = described_class.new(player).call

        expect(result_game).to eq(game)
      end
    end

    context 'when player_o' do
      it 'returns correct game' do
        player = build(:player)
        game = create(:game, :with_players, player_o: player.uuid)

        result_game = described_class.new(player).call

        expect(result_game).to eq(game)
      end
    end
  end

  context 'when waiting game exists' do
    it 'returns correct game' do
      player = build(:player)
      game = create(:game, :waiting)

      result_game = described_class.new(player).call

      expect(result_game).to eq(game)
    end

    it 'sets player as player_o' do
      player = build(:player)
      game = create(:game, :waiting)

      described_class.new(player).call

      expect(game.reload.player_o).to eq player.uuid
    end

    it 'sats game status to active' do
      player = build(:player)
      game = create(:game, :waiting)

      expect do
        described_class.new(player).call
      end.to change { game.reload.state }.from('waiting').to('active')
    end
  end
end
