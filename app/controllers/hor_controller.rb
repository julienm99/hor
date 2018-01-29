class HorController < ApplicationController
  attr_accessor :choix
  
  def index 
    @mc = obtenirToutesLesMetaclasses
  end

  def valider
  end

  def miseAjour   
  end

  def deselectionner
  end
  
  def fixerHoraire    
  end

  def choixMatiere    
  end

  def backbone 
    @mc = metaclasses("backbone") 
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
  
  def coursEPS ; @mc = metaclasses("EPS") ; end

  def infoHoraire    
  end

  def infoCedulables   
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