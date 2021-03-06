class ModelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[show edit update destroy restore]
  before_action :necessary_data, only: %i[new edit create]

  # GET /models
  # GET /models.json
  def index
    @models = Model.all
  end

  # GET /models/1
  # GET /models/1.json
  def show
    @phones = Phone.where(model: params[:id])
  end

  # GET /models/new
  def new
    @model = Model.new
  end

  # GET /models/1/edit
  def edit; end

  # POST /models
  # POST /models.json
  def create
    @model = Model.new(model_params)

    respond_to do |format|
      if @model.save
        format.html { redirect_to @model, notice: 'Model was successfully created.' }
        format.json { render :show, status: :created, location: @model }
      else
        format.html { render :new }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /models/1
  # PATCH/PUT /models/1.json
  def update
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to @model, notice: 'Model was successfully updated.' }
        format.json { render :show, status: :ok, location: @model }
      else
        format.html { render :edit }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.json
  def destroy
    @model.discard
    respond_to do |format|
      format.html { redirect_to models_url, notice: I18n.t('flashes.success.model.deactive') }
      format.json { head :no_content }
    end
  end

  # PATCH/PUT /models/1/restore
  # PATCH/PUT /models/1/restore
  def restore
    @model.undiscard
    respond_to do |format|
      format.html { redirect_to models_url, notice: I18n.t('flashes.success.model.active') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_model
    @model = Model.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def model_params
    params.require(:model).permit(:name, :manufacturer_id, :os_name_id, :year_of_manufacture)
  end

  def necessary_data
    @manufacturers = Manufacturer.all
    @os_names = OsName.all
    @years = (Date.today.year - 10..Date.today.year).to_a.reverse
  end
end
