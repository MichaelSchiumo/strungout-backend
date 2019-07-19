class Api::V1::StringPacksController < ApplicationController
  before_action :set_stringpack, only: [:show, :update, :destroy]

  def index
    if logged_in?
      @stringpacks = current_user.string_packs
      render json: StringPackSerializer.new(@stringpacks)
    else
      render json: {
        error: "You must be logged in to see your string pack"
      }
    end
  end

  # POST /stringpacks
  def create
    @stringpack = StringPack.new(stringpack_params)
    if @stringpack.save
      session[:user_id] = @stringpack.user_id
      render json: StringPackSerializer.new(@stringpacks), status: created
    else
      render json: @stringpack.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stringpacks/1
  def update
    if @stringpack.update(stringpack_params)
      @stringpack.update_string_counter
      render json: StringPackSerializer.new(@stringpacks), status: updated
    else
      render json: @stringpack.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stringpack
      @stringpack = StringPack.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stringpack_params
      params.require(:stringpack).permit(:guage, :brand, :model, :price)
    end
end
