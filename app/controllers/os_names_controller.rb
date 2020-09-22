class OsNamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_os_name, only: %i[show edit update destroy]

  # GET /os_names
  # GET /os_names.json
  def index
    @os_names = OsName.all
  end

  # GET /os_names/1
  # GET /os_names/1.json
  def show; end

  # GET /os_names/new
  def new
    @os_name = OsName.new
  end

  # GET /os_names/1/edit
  def edit; end

  # POST /os_names
  # POST /os_names.json
  def create
    @os_name = OsName.new(os_name_params)

    respond_to do |format|
      if @os_name.save
        format.html { redirect_to @os_name, notice: 'Os name was successfully created.' }
        format.json { render :show, status: :created, location: @os_name }
      else
        format.html { render :new }
        format.json { render json: @os_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /os_names/1
  # PATCH/PUT /os_names/1.json
  def update
    respond_to do |format|
      if @os_name.update(os_name_params)
        format.html { redirect_to @os_name, notice: 'Os name was successfully updated.' }
        format.json { render :show, status: :ok, location: @os_name }
      else
        format.html { render :edit }
        format.json { render json: @os_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /os_names/1
  # DELETE /os_names/1.json
  def destroy
    @os_name.destroy
    respond_to do |format|
      format.html { redirect_to os_names_url, notice: 'Os name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_os_name
    @os_name = OsName.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def os_name_params
    params.require(:os_name).permit(:name, :logo)
  end
end
