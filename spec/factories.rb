# frozen_string_literal: true

FactoryBot.define do
  factory :game do
    trait :with_players do
      state { :active }
      player_x { SecureRandom.uuid }
      player_o { SecureRandom.uuid }
    end

    trait :waiting do
      state { :waiting }
      player_x { SecureRandom.uuid }
    end

    traits_for_enum :state
  end

  factory :player do
    uuid { SecureRandom.uuid }
  end
end
