# frozen_string_literal: true

class GamesController < ApplicationController
  def show
    @player = Player.load_from(cookies.signed)
    @game = Game.find(params[:id])
  end

  def new
    player = Player.load_from(cookies.signed)

    game = Game::Join.new(player).call

    redirect_to game
  end

  def create
    game = Game.create!

    redirect_to game
  end
end
