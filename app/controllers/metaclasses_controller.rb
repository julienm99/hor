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
    @blocMC = params[:blocMC]
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
      params.require(:metaclass).permit(:nom, :status, :niveau, :listeActivites)
    end
    

  def metaclasses(sujet)
    liste = []
    obtenirToutesLesMetaclasses.each do |mc|
      case sujet
      when "backbone"
	liste << mc if %w[EPS ART OPT ANG CHI PHY FM5].include?(mc.nom[0,3])
	liste << mc if %w[MAT4].include?(mc.nom)
	
      when /nivS/
	liste << mc if mc.nom[3,1] == sujet[4,1]
      
      when /Gr/
	list = []
	mc.activites.each do |cours| 
	  cours.listeFoyers.split(",").each{|gr| list << gr unless list.include?(gr)}
	end
	list.each{|gr| liste << mc if gr == sujet }

      when "4-en_traitement"
	liste << mc if mc.status == sujet

      when "SCT"
	liste << mc if  %w[SCT CHI PHY TMS OPT].include?(mc.nom[0,3]) 

      else 
	liste << mc if mc.nom[0,3] == sujet

      end
      
    end
    return liste
  end
  
  
  def obtenirToutesLesMetaclasses
    Metaclass.all.order(:status, :nom) 
  end


end
