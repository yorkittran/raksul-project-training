class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[show destroy restore]

  # GET /inventories
  # GET /inventories.json
  def index
    @warehouse = Phone.joins(:inventories, :memory, :model)
    .select(:model_id,
            :name,
            'SUM(quantity) as total_quantity',
            'MAX(price) as max_price',
            'MIN(price) as min_price',
            'MAX(amount) as max_amount',
            'MIN(amount) as min_amount')
    .group(:model_id)
  end

  # GET /models/1
  # GET /models/1.json
  def show; end

  # GET /phones/new
  def new
    @inventory = Inventory.new
    @models = Model.joins(:manufacturer, :os_name).pluck('models.name', 'manufacturers.name', 'os_names.name').collect do |item|
      "#{item[0]} (#{item[1]} - #{item[2]})"
    end.to_json.html_safe
    @body_colors = BodyColor.pluck(:name).to_json.html_safe
    @memories = Memory.pluck(:display_name).to_json.html_safe
  end

  # POST /inventories
  # POST /inventories.json
  def create
    respond_to do |format|
      if CreateBulkService.call(convert_params, current_user)
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

      item[:model] = Model.where(name: value.split(' (')[0]).first
      item[:body_color] = BodyColor.where(name: params[:body_color][:name][key]).first_or_initialize
      item[:memory] = Memory.where(amount: params[:memory][:amount][key], display_name: params[:memory][:display_name][key]).first_or_initialize # rubocop:disable Layout/LineLength
      item[:os_version] = OsVersion.where(major: params[:os_version][:major][key], minor: params[:os_version][:minor][key], patch: params[:os_version][:patch][key]).first_or_initialize # rubocop:disable Layout/LineLength
      item[:inventory] = Inventory.new(quantity: params[:inventory][:quantity][key], price: params[:inventory][:price][key]) # rubocop:disable Layout/LineLength
      arr << item
    end
    arr
  end
end
