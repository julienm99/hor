class HorController < ApplicationController

  if true # TOP: boutons nav-bar du haut de page
    def contraintes         ; end
    def creerBaseDeDonnees  ; end    
    def updateMetaclasses   ; end    
    def updateCedulables    ; end    
    def deselectionner      ; end
    def infoHoraire         ; end
    def infoCedulables      ; end
    def blocMetaclasses ; @mc = metaclasses(params[:param]) ; end
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


  #~ if true # metaclasses: NIVEAUX
    #~ def nivS1 ; @mc = metaclasses("nivS1") ; end
    #~ def nivS2 ; @mc = metaclasses("nivS2") ; end
    #~ def nivS3 ; @mc = metaclasses("nivS3") ; end
    #~ def nivS4 ; @mc = metaclasses("nivS4") ; end
    #~ def nivS5 ; @mc = metaclasses("nivS5") ; end
  #~ end




  #~ if true # metaclasses: COURS/MATIÈRE/ACTIVITÉS
    def index    ; @mc = obtenirToutesLesMetaclasses ; end
    #~ def backbone ; @mc = metaclasses("backbone")     ; end
    #~ def coursEPS ; @mc = metaclasses("EPS")          ; end
    #~ def coursART ; @mc = metaclasses("ART")          ; end
    #~ def coursANG ; @mc = metaclasses("ANG")          ; end
    #~ def coursFRA ; @mc = metaclasses("FRA")          ; end
    #~ def coursMAT ; @mc = metaclasses("MAT")          ; end
    #~ def coursSCT ; @mc = metaclasses("SCT")          ; end
  #~ end
  
  
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