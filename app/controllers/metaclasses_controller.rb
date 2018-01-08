class MetaclassesController < ApplicationController
  before_action :set_metaclass, only: [:show, :edit, :update, :destroy]

  # GET /metaclasses
  # GET /metaclasses.json
  def index
    @metaclasses = Metaclass.all
  end

  # GET /metaclasses/1
  # GET /metaclasses/1.json
  def show
  end

  # GET /metaclasses/new
  def new
    @metaclass = Metaclass.new
  end

  # GET /metaclasses/1/edit
  def edit
  end

  # POST /metaclasses
  # POST /metaclasses.json
  def create
    @metaclass = Metaclass.new(metaclass_params)

    respond_to do |format|
      if @metaclass.save
        format.html { redirect_to @metaclass, notice: 'Metaclass was successfully created.' }
        format.json { render :show, status: :created, location: @metaclass }
      else
        format.html { render :new }
        format.json { render json: @metaclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metaclasses/1
  # PATCH/PUT /metaclasses/1.json
  def update
    respond_to do |format|
      if @metaclass.update(metaclass_params)
        format.html { redirect_to @metaclass, notice: 'Metaclass was successfully updated.' }
        format.json { render :show, status: :ok, location: @metaclass }
      else
        format.html { render :edit }
        format.json { render json: @metaclass.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metaclasses/1
  # DELETE /metaclasses/1.json
  def destroy
    @metaclass.destroy
    respond_to do |format|
      format.html { redirect_to metaclasses_url, notice: 'Metaclass was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metaclass
      @metaclass = Metaclass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metaclass_params
      params.require(:metaclass).permit(:nom, :fixHor, :fixCedulables, :checked)
    end
end
