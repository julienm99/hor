class HorController < ApplicationController
  
  def index        # les listes sont des variables globales: elles peuvent être utiles partout
    obtenirLesListes( fname = "/home/julienm/hor13/init/metaclasses.txt",
		      $listeMetaclasses=[],
		      $listeActivites=[],
		      $listeFoyers=[],
		      $listeMetaclassesActivites={},
		      $listeActivitesDescription={},
		      $listeMetaclassesEtat={},
		      $listeMetaclassesFoyers={},
		      $listeFoyersMetaclasses={},
		      $listeNiveauxFoyers={})

#~ puts "$listeNiveauxFoyers(#{$listeNiveauxFoyers.class}) = #{$listeNiveauxFoyers}" 

#~ puts "$listeNiveauxFoyers['S1'](#{$listeNiveauxFoyers['S1'].class}) = #{$listeNiveauxFoyers['S1']}" ; exit
		      
    @mc = $listeMetaclasses  # variable équivalente    
    $annee = "2019"
    $repCedulables = "op/cedulables"
  end
 
 
  if true # TOP: boutons nav-bar du haut de page liant les pagesWeb
    def contraintes         ; end
    def updateMetaclasses   ; end    
    def updateCedulables    ; end    
    def infoHoraire         ; end
    def infoCedulables      ; end
  end  
  
  
  def deSelect    
    @status = params[:status]
    @blocMC = params[:blocMC]
  end
  
  
  def changerEtatMetaclasse 
    @mcTraitee = params[:mcTraitee]
    
    case $listeMetaclassesEtat[@mcTraitee]
    when "4-en_traitement"
       $listeMetaclassesEtat[@mcTraitee] = "inactif" 
       
    when "3-cedulables","1-horaire_fixe"
        
    else 
       $listeMetaclassesEtat[@mcTraitee] = "4-en_traitement"
    end
     
    blocMetaclasses
  end
 
 
  def blocMetaclasses 
    @blocMC = params[:blocMC]
    @mc = metaclasses(@blocMC)
    @mc = $listeMetaclasses unless @blocMC
  end
  

  if true # BOTTOM: boutons nav-bar du bas
    def action 
      @blocMC  = params[:blocMC]
      @execute = params[:execute]
    end

    #~ def repartir        ; end
    #~ def valider         ; end
    def invalider       ; end
    def filtrer         ; end
    def fixerHoraire    ; end
    def variance        ; end
    def fixerCedulables ; end
  end

 
  
#~ private
  def metaclasses(sujet)
    
    liste = []    
    $listeMetaclasses.each do |mc|      
      case sujet
      when "backbone"
	liste << mc if %w[EPS ART OPT ANG CHI PHY FM5].include?(mc[0,3])
	liste << mc if %w[MAT4].include?(mc)
	
      when /niveauS/
	$listeNiveauxFoyers[sujet[6,2]].each do |gr|
	    liste << mc if $listeMetaclassesFoyers[mc].include?(gr)
	  end
	liste.uniq!
	  
      when /Gr/
	liste << mc if $listeMetaclassesFoyers[mc].include?(sujet)

      when "4-en_traitement"
	liste << mc if $listeMetaclassesEtat[mc] == sujet

      when "SCT"
	liste << mc if  %w[SCT CHI PHY TMS OPT].include?(mc[0,3]) 

      when "toutesMC"
	liste << mc  

      else 
	liste << mc if mc[0,3] == sujet
	
      end
      
    end
    return liste
  end
  
  

  def obtenirLesListes(	fname,
			listeMetaclasses,
			listeActivites,
			listeFoyers,
			listeMetaclassesActivites,
			listeActivitesDescription,
			listeMetaclassesEtat,
			listeMetaclassesFoyers,
			listeFoyersMetaclasses,
			listeNiveauxFoyers)

    file = File.open(fname, "r:iso8859-1")
    
      while (line = file.gets)
	type, reste = line.split("::")
	
	case type.strip
	when "MetaClasse" 
	  mcNom, activites = reste.split("\t")
	  listeMetaclasses << mcNom
	  listeMetaclassesActivites[mcNom] = activites[14,activites.length].strip
	  listeMetaclassesEtat[mcNom] = "1- inactif" # au départ: toutes les metaclasses sont inactives
	  listeMetaclassesFoyers[mcNom] = []
	  	  
	when "Classe" 
	  nom, description = reste.split("\t")
	  cours, groupe, periodes, periodesTache, semestre, prof, salle, list = reste.split(";")
	  
	  listeActivitesDescription[nom] = description.strip
	  listeActivites << nom
	  listeFoyers << list.strip.split(",")	  
	  listeMetaclassesFoyers[mcNom] << list.strip.split(",")
	  listeMetaclassesFoyers[mcNom].flatten!.uniq!
	  
	else	  
	end
	
      end 
      
    file.close
    
    listeFoyers.flatten!.uniq!.sort!
    
    %w[1 2 3 4 5].each{|niv|listeNiveauxFoyers["S"+niv]=[]} # définir les éléments du hash comme array [] 
    listeFoyers.each{|gr|listeNiveauxFoyers["S"+gr[2]]<< gr unless gr[0]=="P"}   # exemple: dans Gr14 le 1( 3e lettre)signifie @niveauS1
	    
    listeMetaclassesFoyers.each do|mc,foyers|
      foyers.each do |gr|
	listeFoyersMetaclasses[gr]  = [] if listeFoyersMetaclasses[gr] == nil
	listeFoyersMetaclasses[gr] << mc	
      end
    end
	    
    listeMetaclasses.sort!
    listeActivites.sort!
    listeMetaclassesEtat.sort_by{|_key,value| _key} # classé par ordre aphabétique de metaclasses
    listeMetaclassesActivites.sort_by{|_key,value| _key} # classé par ordre aphabétique de metaclasses
    listeActivitesDescription.sort_by{|_key,value| _key} # classé par ordre aphabétique d'activité
    listeMetaclassesFoyers.sort_by{|_key,value| _key} # classé par ordre aphabétique métaclasses
    listeFoyersMetaclasses.sort_by{|_key,value| _key} # classé par ordre de foyers
  end

 

end #class