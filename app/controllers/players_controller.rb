# frozen_string_literal: true

class PlayersController < ApplicationController
  def new
    @player = Player.new
  end

  def create
    player = Player.new(player_params)

    player.save_to(cookies.signed)

    redirect_to new_game_path
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end
