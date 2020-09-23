class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[show destroy restore]

  # GET /inventories
  # GET /inventories.json
  def index
    @warehouse = GroupByPhoneService.call
  end

  # GET /models/1
  # GET /models/1.json
  def show
  end

  # GET /phones/new
  def new
    @inventory = Inventory.new
    @models = Model.pluck(:name).to_json.html_safe
    @body_colors = BodyColor.pluck(:name).to_json.html_safe
    @memories = Memory.pluck(:display_name).to_json.html_safe
  end

  # POST /inventories
  # POST /inventories.json
  def create
    respond_to do |format|
      if create_bulk
        format.html { redirect_to inventories_path, notice: 'Inventory was successfully imported.' }
        format.json { render :index, status: :created, location: inventories_path }
      else
        format.html { render :new }
        format.json { render json: 'error', status: :unprocessable_entity }
      end
    end
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

  def convert_params
    arr = []
    params[:model][:name].each do |key, value|
      item = {}
      item[:model] = Model.where(name: value).first
      item[:body_color] = BodyColor.where(name: params[:body_color][:name][key]).first_or_initialize
      item[:memory] = Memory.where(amount: params[:memory][:amount][key], display_name: params[:memory][:display_name][key]).first_or_initialize
      item[:os_version] = OsVersion.where(major: params[:os_version][:major][key], minor: params[:os_version][:minor][key], patch: params[:os_version][:patch][key]).first_or_initialize
      item[:inventory] = Inventory.new(quantity: params[:inventory][:quantity][key], price: params[:inventory][:price][key])
      arr << item
    end
    arr
  end

  def create_bulk
    convert_params.each do |item|
      ActiveRecord::Base.transaction do
        if item[:body_color].save && item[:memory].save && item[:os_version]
          phone = Phone.create(
            user_id: current_user.id,
            body_color_id: item[:body_color].id,
            memory_id: item[:memory].id,
            os_version_id: item[:os_version].id,
            model_id: item[:model].id
          )
          item[:inventory].phone_id = phone.id
          @inventory = item[:inventory]
          unless @inventory.save
            return false
          end
        end
      end
    end
    true
  end
end
