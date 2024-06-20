class Game < ApplicationRecord
  belongs_to :gemstone

  validates :game_number, presence: true, uniqueness: true
  validates :game_type, presence: true, inclusion: { in: %w[daily random], message: "Game type must be either 'random' or 'daily'" }
  validates :date, presence: true

  def self.create_daily_game
    gemstone = Gemstone.order("RANDOM()").first
    existing_daily_game = Game.find_by(game_type: "daily", date: Date.today)
    return existing_daily_game if existing_daily_game

    Game.create!(
      gemstone: gemstone,
      game_number: Game.where(game_type: "daily").count + 1,
      game_type: "daily",
      date: Date.today
    )
  end
end
