class MemoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_memory, only: %i[show edit update destroy]

  # GET /memories
  # GET /memories.json
  def index
    @memories = Memory.all
  end

  # GET /memories/1
  # GET /memories/1.json
  def show; end

  # GET /memories/new
  def new
    @memory = Memory.new
  end

  # GET /memories/1/edit
  def edit; end

  # POST /memories
  # POST /memories.json
  def create
    @memory = Memory.new(memory_params)

    respond_to do |format|
      if @memory.save
        format.html { redirect_to @memory, notice: 'Memory was successfully created.' }
        format.json { render :show, status: :created, location: @memory }
      else
        format.html { render :new }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memories/1
  # PATCH/PUT /memories/1.json
  def update
    respond_to do |format|
      if @memory.update(memory_params)
        format.html { redirect_to @memory, notice: 'Memory was successfully updated.' }
        format.json { render :show, status: :ok, location: @memory }
      else
        format.html { render :edit }
        format.json { render json: @memory.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_memory
    @memory = Memory.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def memory_params
    params.require(:memory).permit(:amount, :display_name)
  end
end
