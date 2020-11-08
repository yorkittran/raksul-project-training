class InventoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_model, only: %i[destroy restore]
  before_action :set_data, only: %i[new create]

  # GET /inventories
  # GET /inventories.json
  def index
    @warehouse = Phone.joins(:memory, :inventories, :model).select(:model_id, :name, 'SUM(quantity) as total_quantity', 'MAX(price) as max_price', 'MIN(price) as min_price', 'MAX(amount) as max_amount', 'MIN(amount) as min_amount').where('inventories.discarded_at IS NULL').where('models.discarded_at IS NULL').group(:model_id) # rubocop:disable Layout/LineLength
  end

  # GET /inventories/new
  def new; end

  # POST /inventories
  # POST /inventories.json
  def create
    respond_to do |format|
      begin
        Inventories::BulkCreateService.call(convert_params, current_user)
        format.html { redirect_to inventories_path, notice: 'Inventory was successfully imported.' }
        format.json { render :index, status: :created, location: inventories_path }
      rescue ActiveRecord::RecordInvalid => e
        flash.now[:alert] = e.message
        format.html { render :new }
        format.json { render json: @inventory, status: :unprocessable_entity }
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

  def model_params
    params.require(:model_id)
  end

  def set_data
    @inventory = Inventory.new
    @models = Model.select(:id, :name).order(:name)
    @body_colors = BodyColor.select(:id, :name).to_json.html_safe
    @memories = Memory.select(:id, :display_name).to_json.html_safe
  end

  def convert_params
    arr = []
    params[:model].each do |key, value|
      os_version = validated_os_version(params[:os_version][key])
      return false unless os_version

      item = {}
      item[:model] = Model.find(value)
      item[:body_color] = BodyColor.find(params[:body_color][key])
      item[:memory] = Memory.find(params[:body_color][key])
      item[:os_version] = OsVersion.where(
        major: os_version[0],
        minor: os_version[1].nil? ? 0 : os_version[1],
        patch: os_version[2].nil? ? 0 : os_version[2],
      ).first_or_initialize
      item[:inventory] = Inventory.new(quantity: params[:quantity][key], price: params[:price][key])
      arr << item
    end
    arr
  end

  def validated_os_version(params)
    os_version = params.split('.', -1)
    return false unless os_version.length < 4 && os_version.any?

    os_version.collect do |element|
      element = "0" if element.empty?
      return false unless element.match(/^(\d)+$/)
    end
    os_version
  end
end
