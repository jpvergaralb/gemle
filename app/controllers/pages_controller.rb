class PagesController < ApplicationController
  def home
    @gemstones = Gemstone.all
  end

  def about
    render json: { response: "This is a simple API for gemstones" }, status: :ok
  end

  def contact
    render json: { response: "You can reach us at jpvergaralb@uc.cl" }, status: :ok
  end

  def daily
    @game = Game.create_daily_game
    @gemstone = @game.gemstone
  end

  def random

  end

end
