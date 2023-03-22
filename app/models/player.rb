# frozen_string_literal: true

class Player
  include ActiveModel::Model

  attr_writer :name, :uuid

  def name
    @name ||= 'Guest'
  end

  def uuid
    @uuid ||= SecureRandom.uuid
  end

  def save_to(cookies)
    cookies[:player_name] = name
    cookies[:player_uuid] = uuid
  end

  def self.load_from(cookies)
    Player.new(name: cookies[:player_name], uuid: cookies[:player_uuid])
  end
end
