class GemstonesController < ApplicationController
  before_action :set_gemstone, only: %i[ show edit update destroy ]
  skip_before_action :verify_authenticity_token, only: [:create], if: :json_request?

  # GET /gemstones or /gemstones.json
  def index
    @gemstones = Gemstone.all 
    @games = Game.all
    render json: { response: { gemstones: @gemstones, games: @games }}, status: :ok
  end

  # GET /gemstones/1 or /gemstones/1.json
  def show
    render json: { response: params}, status: :ok
  end

  # GET /gemstones/1/edit
  def edit
  end

  # POST /gemstones or /gemstones.json
  def create
    @gemstone = Gemstone.new(gemstone_params)
    begin
      @gemstone.save!
      render json: { response: @gemstone}, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { error: e.message}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gemstones/1 or /gemstones/1.json
  def update
    respond_to do |format|
      if @gemstone.update(gemstone_params)
        format.html { redirect_to gemstone_url(@gemstone), notice: "Gemstone was successfully updated." }
        format.json { render :show, status: :ok, location: @gemstone }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @gemstone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gemstones/1 or /gemstones/1.json
  def destroy
    @gemstone.destroy!

    respond_to do |format|
      format.html { redirect_to gemstones_url, notice: "Gemstone was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_gemstone
    begin
      @gemstone = Gemstone.find(params[:id])
      render json: { response: @gemstone}, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Gemstone of id #{params[:id]} not found"}, status: :not_found
    end
  end

  # Only allow a list of trusted parameters through.
  def gemstone_params
    params.require(:gemstone).permit(:name, :image_url, can_be_found_in: [])
  end

  def json_request?
    request.format.json?
  end
end
