class GamesController < ApplicationController
    before_action :set_game, only: %i[show update destroy]
    skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy], if: :json_request?
  
    def index
      @games = Game.all
      render json: { response: @games }, status: :ok
    end
  
    # will return the game with the id passed in the URL
    def show
      render json: { response: @game.as_json(include: :gemstone) }, status: :ok
    end
  
    # expects a JSON object with the following structure:
    # {
    #   "game_type": "daily"
    # }
    def create
      gemstone = pick_unique_random_gemstone()
      game_type = params[:game_type] || "daily"
  
      if game_type == "daily"
        existing_daily_game = Game.find_by(game_type: "daily", date: Date.today)
        if existing_daily_game
          render json: { response: existing_daily_game, status: :existing_game }, status: :ok
          return
        end
      end
      puts Game.where(game_type: game_type).count + 1
      @game = Game.new(
        gemstone: gemstone,
        game_number: Game.where(game_type: game_type).maximum(:game_number).to_i + 1,
        game_type: game_type,
        date: Date.today
      )
  
      if @game.save
        render json: { response: @game, status: :new_game }, status: :created
      else
        render json: { error: @game.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      if @game.update(game_params)
        render json: { response: @game }, status: :ok
      else
        render json: { error: @game.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      begin
        @game.destroy!
        render json: { response: "Game was successfully destroyed." }, status: :ok
      rescue ActiveRecord::RecordNotDestroyed => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_game
      begin
        @game = Game.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
      end
    end
  
    def game_params
      params.permit(:game_type)
    end
  
    def json_request?
      request.format.json?
    end

    def pick_unique_random_gemstone
      used_gemstone_ids = Game.where.not(gemstone_id: nil).pluck(:gemstone_id)
      gemstone = Gemstone.where.not(id: used_gemstone_ids).order("RANDOM()").first
      gemstone
    end
  end
  