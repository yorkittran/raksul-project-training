class PhonesController < ApplicationController
  before_action :set_phone, only: [:show, :edit, :update, :destroy]
  before_action :get_necessary_data, only: [:new, :edit]

  # GET /phones
  # GET /phones.json
  def index
    @warehouse = []
    models = Phone.select(:model_id).group(:model_id)
    models.each do |model|
      item = {}
      item[:model_id] = model.model_id
      item[:model_name] = Model.find(model.model_id).name
      minimum_memory = Memory.where(amount: Phone.joins(:memory).where(model_id: model.model_id).minimum(:amount)).pick(:display_name)
      maximum_memory = Memory.where(amount: Phone.joins(:memory).where(model_id: model.model_id).maximum(:amount)).pick(:display_name)
      minimum_price = Inventory.joins(:phone).where(phone: Phone.where(model_id: model.model_id)).minimum(:price)
      maximum_price = Inventory.joins(:phone).where(phone: Phone.where(model_id: model.model_id)).maximum(:price)
      item[:total_quantity] = Inventory.joins(:phone).where(phone: Phone.where(model_id: model.model_id)).sum(:quantity)
      if minimum_memory == maximum_memory
        item[:memory_range] = maximum_memory
      else
        item[:memory_range] = minimum_memory + " - " + maximum_memory
      end
      if minimum_price == maximum_price
        item[:price_range] = "#{maximum_price}$"
      else
        item[:price_range] = "#{minimum_price}$ - #{maximum_price}$"
      end
      @warehouse << item
    end
  end

  # GET /phones/1
  # GET /phones/1.json
  def show
  end

  # GET /phones/new
  def new
    @phone = Phone.new
  end

  # GET /phones/1/edit
  def edit
  end

  # POST /phones
  # POST /phones.json
  def create
    success = true
    model_params[:name].each do |key, value|
      model = Model.where(name: value).first
      body_color = BodyColor.where(name: body_color_params[:name][key]).first_or_initialize
      memory = Memory.where(
        amount: memory_params[:amount][key],
        display_name: memory_params[:display_name][key]
      ).first_or_initialize
      os_version = OsVersion.where(
        major: os_version_params[:major][key],
        minor: os_version_params[:minor][key],
        patch: os_version_params[:patch][key]
      ).first_or_initialize

      if body_color.save && memory.save && os_version.save
        phone = Phone.where(
          user_id: current_user.id,
          body_color_id: body_color.id,
          memory_id: memory.id,
          os_version_id: os_version.id,
          model_id: model.id
        ).first_or_initialize

        inventory = Inventory.where(
          phone_id: phone.id,
          price: inventory_params[:price][key]
        ).first_or_initialize

        @phone = phone
        unless phone.save
          success = false
        else
          if Inventory.exists?(id: inventory.id)
            inventory.update(quantity: inventory.quantity + inventory_params[:quantity][key].to_i)
          else
            inventory.update(quantity: inventory_params[:quantity][key])
          end
        end
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

    def get_necessary_data
      @models = Model.pluck(:name).to_json.html_safe
      @body_colors = BodyColor.pluck(:name).to_json.html_safe
      @memories = Memory.pluck(:display_name).to_json.html_safe
    end
end
