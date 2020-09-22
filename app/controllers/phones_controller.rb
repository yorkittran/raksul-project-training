class PhonesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_phone, only: %i[show edit update destroy]
  before_action :necessary_data, only: %i[new edit]

  # GET /phones
  # GET /phones.json
  def index
    @warehouse = {}
    inventories = Inventory.kept
    inventories.each do |inventory|
      @warehouse[inventory.phone.model.id] =
        @warehouse.key?(inventory.phone.model.id) ? change_item(inventory) : init_item(inventory)
    end
  end

  # GET /phones/1
  # GET /phones/1.json
  def show; end

  # GET /phones/new
  def new
    @phone = Phone.new
  end

  # GET /phones/1/edit
  def edit; end

  # POST /phones
  # POST /phones.json
  def create
    success = true
    model_params[:name].each do |key, value|
      next unless create_sub_record(key, value)

      unless create_phone && create_inventory(key)
        success = false
        break
      end
    end

    respond_to do |format|
      if success
        format.html { redirect_to phones_path, notice: 'Phone was successfully imported.' }
        format.json { render :index, status: :created, location: phones_path }
      else
        format.html { render :new }
        format.json { render json: "errors", status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /phones/1
  # PATCH/PUT /phones/1.json
  def update
    respond_to do |format|
      if @phone.update(phone_params)
        format.html { redirect_to @phone, notice: 'Phone was successfully updated.' }
        format.json { render :show, status: :ok, location: @phone }
      else
        format.html { render :edit }
        format.json { render json: @phone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /phones/1
  # DELETE /phones/1.json
  def destroy
    @phone.destroy
    respond_to do |format|
      format.html { redirect_to phones_url, notice: 'Phone was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_phone
    @phone = Phone.find(params[:id])
  end

  # Get list of name in model param.
  def model_params
    params.require(:model)
  end

  # Get list of name in body_color param.
  def body_color_params
    params.require(:body_color)
  end

  # Get list of name in memory param.
  def memory_params
    params.require(:memory)
  end

  # Get list of name in inventory param.
  def inventory_params
    params.require(:inventory)
  end

  # Get list of name in os_version param.
  def os_version_params
    params.require(:os_version)
  end

  # Set inventory data to a new item for hash
  def init_item(inventory)
    item = {}
    item[:model_name] = inventory.phone.model.name
    item[:quantity] = inventory.quantity
    item[:price_min] = inventory.price
    item[:price_max] = inventory.price
    item[:price] = "#{inventory.price}$"
    item[:memory_min] = inventory.phone.memory.amount
    item[:memory_max] = inventory.phone.memory.amount
    item[:memory] = inventory.phone.memory.display_name
    item
  end

  # Update data for existed item in hash
  def change_item(inventory)
    item = @warehouse[inventory.phone.model.id]
    item[:quantity] += inventory.quantity

    unless item[:price_min] == inventory.price && item[:price_max] == inventory.price
      item[:price_min] = [item[:price_min], inventory.price].min
      item[:price_max] = [item[:price_max], inventory.price].max
      item[:price] = "#{item[:price_min]}$ - #{item[:price_max]}$"
    end

    unless item[:memory_min] == inventory.phone.memory.amount && item[:memory_max] == inventory.phone.memory.amount
      item[:memory_min] = [item[:memory_min], inventory.phone.memory.amount].min
      item[:memory_max] = [item[:memory_max], inventory.phone.memory.amount].max
      item[:memory] = Memory.where(amount: item[:memory_min]).pick(:display_name) + " - " + Memory.where(amount: item[:memory_max]).pick(:display_name)
    end
    item
  end

  # Get showing data
  def necessary_data
    @models = Model.pluck(:name).to_json.html_safe
    @body_colors = BodyColor.pluck(:name).to_json.html_safe
    @memories = Memory.pluck(:display_name).to_json.html_safe
  end

  # Create some record if not exist
  def create_sub_record(key, value)
    @model = Model.where(name: value).first
    @body_color = BodyColor.where(name: body_color_params[:name][key]).first_or_initialize
    @memory = Memory.where(
      amount: memory_params[:amount][key],
      display_name: memory_params[:display_name][key],
    ).first_or_initialize
    @os_version = OsVersion.where(
      major: os_version_params[:major][key],
      minor: os_version_params[:minor][key],
      patch: os_version_params[:patch][key],
    ).first_or_initialize

    @body_color.save && @memory.save && @os_version.save
  end

  # Create phone
  def create_phone
    @phone = Phone.where(
      user_id: current_user.id,
      body_color_id: @body_color.id,
      memory_id: @memory.id,
      os_version_id: @os_version.id,
      model_id: @model.id,
    ).first_or_initialize

    @phone.save
  end

  # Create inventory depends on
  def create_inventory(key)
    @inventory = Inventory.where(
      phone_id: @phone.id,
      price: inventory_params[:price][key],
    ).first_or_initialize

    if Inventory.exists?(id: @inventory.id)
      @inventory.update(quantity: @inventory.quantity + inventory_params[:quantity][key].to_i)
    else
      @inventory.quantity = inventory_params[:quantity][key]
      @inventory.save
    end
  end
end
