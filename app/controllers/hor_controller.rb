class HorController < ApplicationController
  
  def index        # les listes sont des variables globales($): elles servent de base de donn�es
    obtenirLesListes( fname = "/home/julienm/hor13/init/metaclasses.txt",
		      $listeMetaclasses=[],  # listeXxxxx = array
		      $listeActivites=[],
		      $listeFoyers=[],
		      $listeProfs=[],
		      $listeChevauchent=[],
		      $listeMetaclassesActivites={},# listeXxxxYyyy = hash{Xxxx = key, Yyyy = value}
		      $listeActivitesDescription={},
		      $listeMetaclassesEtat={},
		      $listeMetaclassesFoyers={},
		      $listeMetaclassesProfs={},
		      $listeFoyersMetaclasses={},
		      $listeNiveauxFoyers={},
		      $listeProfsFoyers={},
		      $listeProfsCycle={}
		    )
		    
    $listeMetaclassesProfs.each{|mc,prof| $listeChevauchent -= prof if mc[0,3] == "EPS"}
		      
    #~ puts "$listeProfsFoyers(#{$listeProfsFoyers.class}) = #{$listeProfsFoyers}"
    #~ puts "$listeChevauchent(#{$listeChevauchent.class}) = #{$listeChevauchent}"
    #~ exit
    
    @mc = $listeMetaclasses  # variable �quivalente 
    @blocMC = "index"
    $annee = "2019"
    $repCedulables = "op/cedulables" # rep = r�pertoire
    $repDiag = "op/diag" # rep = r�pertoire
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
    @execute = params[:execute]
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
			listeProfs,
			listeChevauchent,
			listeMetaclassesActivites,
			listeActivitesDescription,
			listeMetaclassesEtat,
			listeMetaclassesFoyers,
			listeMetaclassesProfs,
			listeFoyersMetaclasses,
			listeNiveauxFoyers,
			listeProfsFoyers,
			listeProfsCycle
		      )

    file = File.open(fname, "r:iso8859-1")
    
      while (line = file.gets)
	type, reste = line.split("::")
	
	case type.strip
	when "MetaClasse" 
	  mcNom, activites = reste.split("\t")
	  listeMetaclasses << mcNom
	  listeMetaclassesActivites[mcNom] = activites[14,activites.length].strip
	  listeMetaclassesEtat[mcNom] = "inactif" # au d�part: toutes les metaclasses sont inactives
	  listeMetaclassesFoyers[mcNom] = []
	  listeMetaclassesProfs[mcNom] = []

	  
	when "Classe" 
	  nomActivite, description = reste.split("\t")
	  cours,groupe,periodes,periodesTache,semestre,prof,salle,listFoyers = description.split(";")
	  
	  listeActivitesDescription[nomActivite] = description.strip
	  
	  listeActivites << nomActivite
	  listeProfs << prof
	  
	  listeFoyers << listFoyers.strip.split(",")
	  
	  listeMetaclassesFoyers[mcNom] << listFoyers.strip.split(",")
	  listeMetaclassesFoyers[mcNom].flatten!.uniq!
	  
	  listeMetaclassesProfs[mcNom] << prof.strip
	  listeMetaclassesProfs[mcNom].uniq!
	  	  

	  listeProfsFoyers[prof] = [] if listeProfsFoyers[prof] == nil
	  listeProfsFoyers[prof] << listFoyers.strip.split(",")
	  listeProfsFoyers[prof].flatten!.uniq!
	  
	
	else	  
	end
	
      end 
      
    file.close
#~ ------------------------------------------------    
        #~ puts "$listeProfsFoyers(#{$listeProfsFoyers.class}) = #{$listeProfsFoyers.class}"
    #~ exit
#~ ---------------------------------------------
    #~ liste_PROFS => CYCLE  "1", "2" ou "0" (0 prof qui enseigne aux 2 cycles)
    listeFoyers.flatten!.uniq!.sort!
    listeProfsFoyers.each do |prof,foyers|
	cycle = []
	foyers.each do |gr| 
	   cycle << "1" if  gr[2]=="1" || gr[2]=="2" 
	   cycle << "2" if  gr[2]=="3" || gr[2]=="4" || gr[2]=="5" 
	 end
	 cycle.uniq!
	 listeProfsCycle[prof]= "1" if cycle[0] == "1"
	 listeProfsCycle[prof]= "2" if cycle[0] == "2"
	 listeProfsCycle[prof]= "0" if cycle.size == 2
       end
#~ ---------------------------------------------
    #~ liste_PROFS_QUI_CHEVAUCHENT sans[EPS] ProfsCycle = "0" (0 prof qui enseigne aux 2 cycles) - EPS       
    listeProfs.uniq!.sort!
#~ puts "AVANT listeChevauchent(#{listeChevauchent.class}) = #{listeChevauchent}"
    listeProfs.each{|prof| listeChevauchent << prof if listeProfsCycle[prof] == "0"}
    #~ listeMetaclassesProfs.each{|mc,prof| listeChevauchent -= prof if mc[0,3] == "EPS"}    
#~ puts "APRES: listeChevauchent(#{listeChevauchent.class}) = #{listeChevauchent}"
#~ exit 
	
    %w[1 2 3 4 5].each{|niv|listeNiveauxFoyers["S"+niv]=[]} # d�finir les �l�ments du hash comme array [] 
    listeFoyers.each{|gr|listeNiveauxFoyers["S"+gr[2]]<< gr unless gr[0]=="P"}   # exemple: dans Gr14 le 1( 3e lettre)signifie @niveauS1
	    
    listeMetaclassesFoyers.each do|mc,foyers|
      foyers.each do |gr|
	listeFoyersMetaclasses[gr]  = [] if listeFoyersMetaclasses[gr] == nil
	listeFoyersMetaclasses[gr] << mc	
      end
    end
	
    listeMetaclasses.sort!
    listeActivites.sort!
    listeMetaclassesEtat.sort_by{|_key,value| _key} # class� par ordre aphab�tique de metaclasses
    listeMetaclassesActivites.sort_by{|_key,value| _key} # class� par ordre aphab�tique de metaclasses
    listeActivitesDescription.sort_by{|_key,value| _key} # class� par ordre aphab�tique d'activit�
    listeMetaclassesFoyers.sort_by{|_key,value| _key} # class� par ordre aphab�tique m�taclasses
    listeMetaclassesProfs.sort_by{|_key,value| _key} # class� par ordre aphab�tique m�taclasses
    listeFoyersMetaclasses.sort_by{|_key,value| _key} # class� par ordre de foyers
    listeProfsFoyers.sort_by{|_key,value| _key} # class� par ordre de foyers
    listeChevauchent
  end

 

end #class