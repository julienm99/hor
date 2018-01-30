class HorController < ApplicationController
  attr_accessor :choix

  if true # TOP: boutons nav-bar du haut de page
    def choixMatiere    
    end

    def deselectionner
    end
    
    def miseAjour   
    end
    
    def infoHoraire    
    end

    def infoCedulables   
    end

  end
  
  if true # BOTTOM: boutons nav-bar du bas
    def valider
    end
    
    def fixerHoraire    
    end

  end

  if true # metaclasses: NIVEAUX
    def nivS1 ; @mc = metaclasses("nivS1") ; end
    def nivS2 ; @mc = metaclasses("nivS2") ; end
    def nivS3 ; @mc = metaclasses("nivS3") ; end
    def nivS4 ; @mc = metaclasses("nivS4") ; end
    def nivS5 ; @mc = metaclasses("nivS5") ; end
  end
  
  if true # metaclasses: GROUPES
    def gr21 ; @mc = metaclasses("Gr21") ; end
    
    def gr31 ; @mc = metaclasses("Gr31") ; end
    def gr32 ; @mc = metaclasses("Gr32") ; end
    def gr33 ; @mc = metaclasses("Gr33") ; end
    def gr34 ; @mc = metaclasses("Gr34") ; end
    def gr35 ; @mc = metaclasses("Gr35") ; end
    def gr36 ; @mc = metaclasses("Gr36") ; end
    def gr37 ; @mc = metaclasses("Gr37") ; end
    def gr38 ; @mc = metaclasses("Gr38") ; end
    def gr39 ; @mc = metaclasses("Gr39") ; end

    def gr41 ; @mc = metaclasses("Gr41") ; end
    def gr42 ; @mc = metaclasses("Gr42") ; end
    def gr43 ; @mc = metaclasses("Gr43") ; end
    def gr44 ; @mc = metaclasses("Gr44") ; end
    def gr45 ; @mc = metaclasses("Gr45") ; end
    def gr46 ; @mc = metaclasses("Gr46") ; end
    def gr47 ; @mc = metaclasses("Gr47") ; end
    def gr48 ; @mc = metaclasses("Gr48") ; end
    def gr49 ; @mc = metaclasses("Gr49") ; end

    def gr51 ; @mc = metaclasses("Gr51") ; end
    def gr52 ; @mc = metaclasses("Gr52") ; end
    def gr53 ; @mc = metaclasses("Gr53") ; end
    def gr54 ; @mc = metaclasses("Gr54") ; end
    def gr55 ; @mc = metaclasses("Gr55") ; end
    def gr56 ; @mc = metaclasses("Gr56") ; end
    def gr57 ; @mc = metaclasses("Gr57") ; end
    def gr58 ; @mc = metaclasses("Gr58") ; end
    def gr59 ; @mc = metaclasses("Gr59") ; end
  end


  if true # metaclasses: COURS/MATIÈRE/ACTIVITÉS
    def index    ; @mc = obtenirToutesLesMetaclasses ; end
    def backbone ; @mc = metaclasses("backbone") ; end
    def coursEPS ; @mc = metaclasses("EPS") ; end
    def coursART ; @mc = metaclasses("ART") ; end
    def coursANG ; @mc = metaclasses("ANG") ; end
    def coursFRA ; @mc = metaclasses("FRA") ; end
    def coursMAT ; @mc = metaclasses("MAT") ; end
    def coursSCT ; @mc = metaclasses("SCT") ; end
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
	liste << mc if  %w[SCT, CHI, PHY, TMS, OPT].include?(mc.nom[0,3]) 

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