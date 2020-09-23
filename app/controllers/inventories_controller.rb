class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[show destroy restore]

  # GET /models/1
  # GET /models/1.json
  def show
  end

  # DELETE /inventory/1
  # DELETE /inventory/1.json
  def destroy
    @inventory.discard
    respond_to do |format|
      format.html { redirect_to model_url(model_params), notice: 'Inventory was successfully deactive.' }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /inventory/1/restore
  # PATCH/PUT /inventory/1/restore
  def restore
    @inventory.undiscard
    respond_to do |format|
      format.html { redirect_to model_url(model_params), notice: 'Inventory was successfully active.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_model
    @inventory = Inventory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def model_params
    params.require(:model_id)
  end

end
