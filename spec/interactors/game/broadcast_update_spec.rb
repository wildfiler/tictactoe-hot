# frozen_string_literal: true

require 'rails_helper'

describe Game::BroadcastUpdate do
  it 'broadcasts update to player_x game stream' do
    game = build_stubbed(:game, :with_players)

    streams_channel = Turbo::StreamsChannel
    allow(streams_channel).to receive(:broadcast_update_to).and_call_original

    described_class.new(game).call

    expect(streams_channel).to have_received(:broadcast_update_to)
      .with(
        game,
        game.player_x,
        target: "game_#{game.id}",
        partial: game,
        locals: {
          game:,
          player: have_attributes(uuid: game.player_x),
        },
      )
  end

  it 'broadcasts update to player_o game stream' do
    game = build_stubbed(:game, :with_players)

    streams_channel = Turbo::StreamsChannel
    allow(streams_channel).to receive(:broadcast_update_to).and_call_original

    described_class.new(game).call

    expect(streams_channel).to have_received(:broadcast_update_to)
      .with(
        game,
        game.player_o,
        target: "game_#{game.id}",
        partial: game,
        locals: {
          game:,
          player: have_attributes(uuid: game.player_o),
        },
      )
  end
end
