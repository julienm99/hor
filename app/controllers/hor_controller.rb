class HorController < ApplicationController
  
  
    def index           ; 
      @mc = obtenirToutesLesMetaclasses
      @annee = "2019"
      @repCedulables = "op/cedulables"
    end
    
  if true # TOP: boutons nav-bar du haut de page liant les pagesWeb
    def contraintes         ; end
    def creerBaseDeDonnees  ; end    
    def updateMetaclasses   ; end    
    def updateCedulables    ; end    
    def infoHoraire         ; end
    def infoCedulables      ; end
    
    def deSelect    
      @status = params[:param]
    end
    
    def blocMetaclasses 
      @blocMC = params[:blocMC]
      @mc = metaclasses(@blocMC)
    end
  end


  if true # BOTTOM: boutons nav-bar du bas
    def repartir        ; end
    def valider         ; end
    def invalider       ; end
    def filtrer         ; end
    def fixerHoraire    ; end
    def variance        ; end
    def fixerCedulables ; end
  end

 
  
private
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



end #class