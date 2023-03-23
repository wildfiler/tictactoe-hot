# frozen_string_literal: true

require 'rails_helper'

describe 'User starts the game' do
  it 'waits for other player to join the game' do
    join_the_game

    within('#game') do
      expect(page).to have_css('.notice', text: 'Waiting for other player to join...')
    end
  end

  context 'when waiting game exists' do
    it 'joins the game as O' do
      _game = create(:game, :waiting)

      join_the_game

      within('#game') do
        expect(page).to have_css('.notice', text: 'You are playing for O.')
      end
    end
  end

  context 'when another user joins the game' do
    it 'plays the game as X' do
      join_the_game

      using_session('another player') do
        join_the_game
      end

      refresh

      within('#game') do
        expect(page).to have_css('.notice', text: 'You are playing for X.')
      end
    end
  end

  context 'when user tries to rejoin' do
    it 'does not start new game' do
      join_the_game

      within('#game') do
        expect(page).to have_css('.notice', text: 'Waiting for other player to join...')
      end

      visit '/'
      click_on 'Join the game!'

      within('#game') do
        expect(page).to have_css('.notice', text: 'Waiting for other player to join...')
      end
    end
  end

  def join_the_game
    visit '/'
    fill_in 'Name:', with: 'Joe'
    click_on 'Join the game!'
  end
end
