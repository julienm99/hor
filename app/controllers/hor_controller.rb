class HorController < ApplicationController
  
  def index        # les listes sont des variables globales($): elles servent de base de données
    obtenirLesListes( fname = "/home/julienm/hor13/init/metaclasses.txt",
		      $listeMetaclasses=[],  # listeXxxxx = array
		      $listeActivites=[],
		      $listeFoyers=[],
		      $listeMetaclassesActivites={},# listeXxxxYyyy = hash{Xxxx = key, Yyyy = value}
		      $listeActivitesDescription={},
		      $listeMetaclassesEtat={},
		      $listeMetaclassesFoyers={},
		      $listeMetaclassesProfs={},
		      $listeFoyersMetaclasses={},
		      $listeNiveauxFoyers={},
		      $listeProfsFoyers={})

    @mc = $listeMetaclasses  # variable équivalente    
    $annee = "2019"
    $repCedulables = "op/cedulables" # rep = répertoire
    $repHoraire = "data"
  end
 
   
  def deSelect    
    @blocMC = params[:blocMC]
  end
  
  
  def changerEtatMetaclasse # interchanger "inactif" <--> "4-en_traitement"
    @mcTraitee = params[:mcTraitee]
    mc = $listeMetaclassesEtat
    
    mc[@mcTraitee]=="inactif" ? mc[@mcTraitee]="4-en_traitement" : mc[@mcTraitee]="inactif" 
    
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

      when "index"
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
			listeMetaclassesProfs,
			listeFoyersMetaclasses,
			listeNiveauxFoyers,
			listeProfsFoyers)

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
	  listeMetaclassesProfs[mcNom] = []
	  
	  
	when "Classe" 
	  nomActivite, description = reste.split("\t")
	  cours, groupe, periodes, periodesTache, semestre, prof, salle, listFoyers = reste.split(";")
	  
	  listeActivitesDescription[nomActivite] = description.strip
	  
	  listeActivites << nomActivite
	  
	  listeFoyers << listFoyers.strip.split(",")
	  
	  listeMetaclassesFoyers[mcNom] << listFoyers.strip.split(",")
	  listeMetaclassesFoyers[mcNom].flatten!.uniq!
	  
	  listeMetaclassesProfs[mcNom] << prof.strip
	  listeMetaclassesProfs[mcNom].uniq!
	  
	  #~ listeProfsFoyers[prof] = [] if listeProfsFoyers[prof] == NilClass
	  #~ listeProfsFoyers[prof] << listFoyers.strip.split(",")
	  #~ listeProfsFoyers[prof].flatten!.uniq!
	  
	  
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
	puts listeProfsFoyers
	
    listeMetaclasses.sort!
    listeActivites.sort!
    listeMetaclassesEtat.sort_by{|_key,value| _key} # classé par ordre aphabétique de metaclasses
    listeMetaclassesActivites.sort_by{|_key,value| _key} # classé par ordre aphabétique de metaclasses
    listeActivitesDescription.sort_by{|_key,value| _key} # classé par ordre aphabétique d'activité
    listeMetaclassesFoyers.sort_by{|_key,value| _key} # classé par ordre aphabétique métaclasses
    listeMetaclassesProfs.sort_by{|_key,value| _key} # classé par ordre aphabétique métaclasses
    listeFoyersMetaclasses.sort_by{|_key,value| _key} # classé par ordre de foyers
    listeProfsFoyers.sort_by{|_key,value| _key} # classé par ordre de foyers
  end

 

end #class