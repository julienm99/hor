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

  def nivS5
    @mc = metaclasses("nivS5")
  end

  def infoHoraire    
  end

  def infoCedulables   
  end

  def metaclassesEPS
    @mc = metaclasses("EPS")
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