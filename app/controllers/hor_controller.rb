class HorController < ApplicationController

  def index        # les listes sont des variables globales($): elles servent de base de donn�es

    paramsAutorises

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
		      $listeMetaclassesPeriodes={},
		      $listeFoyersMetaclasses={},
		      $listeNiveauxFoyers={},
		      $listeProfsFoyers={},
		      $listeProfsCycle={},
		      $listeProfsPeriodes={},
		      $listeProfsMetaclasses={}
		    )

    $listeMetaclassesProfs.each{|mc,prof| $listeChevauchent -= prof if mc[0,3] == "EPS"}

    #~ puts "$listeProfsMetaclasses(#{$listeProfsMetaclasses.class}) = #{$listeProfsMetaclasses}"
    #~ puts "$listeMetaclassesPeriodes(#{$listeMetaclassesPeriodes.class}) = #{$listeMetaclassesPeriodes}"
    #~ puts "$listeChevauchent(#{$listeChevauchent.class}) = #{$listeChevauchent}"
    #~ exit

    @mc = $listeMetaclasses  # variables �quivalentes
    @blocMC = "index"
    $annee = Time.now.to_s[0,4] 
    $dirCedulables = "op/cedulables" # dir = directory (r�pertoire)
    $dirDiag = "op/diag"
    $dirHoraire = "data"
  end


  def deSelect
    @blocMC = params[:blocMC]
    @mc = @blocMC
  end


  def parade
    @blocMC  = params[:blocMC]
    @execute = params[:execute]
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


  def paramsAutorises
    params = ActionController::Parameters.new
    ActionController::Parameters.permit_all_parameters = true
  end


  def action
    @blocMC         = params[:blocMC]
    @execute        = params[:execute]
    @niv            = params[:niv]
    @fname          = params[:fname]
    @matieresEtat   = params[:matieresEtat]
    @matieresFiltre = params[:matieresFiltre]
    @matiere        = params[:matiere]
    @etat 	        = params[:etat]
    @sizeFile 	    = params[:sizeFile]
    @transfert_PAS  = params[:transfert_PAS]  # PAS : site web "Planification Ann�e Scolaire"
    @segment        = params[:segment]  
  end




#~ private
  def metaclasses(sujet)

    liste = []
    $listeMetaclasses.each do |mc|
      case sujet
      when "backbone"
	      liste << mc if %w[EPS ART OPT ANG CHI PHY FM5 MON].include?(mc[0,3])
	      liste << mc if %w[MAT5 FRA5].include?(mc[0,4])

      when /niveauS/
	      $listeNiveauxFoyers[sujet[6,2]].each do |gr|
	        liste << mc if $listeMetaclassesFoyers[mc].include?(gr)
	      end
	      liste.uniq!

      when /Gr/
	      liste << mc if $listeMetaclassesFoyers[mc].include?(sujet)

      when "MON"
	      liste << mc unless /MON/.match(mc) == nil

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
			listeMetaclassesPeriodes,
			listeFoyersMetaclasses,
			listeNiveauxFoyers,
			listeProfsFoyers,
			listeProfsCycle,
			listeProfsPeriodes,
			listeProfsMetaclasses
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
      listeMetaclassesPeriodes[mcNom] = []

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

	  listeProfsPeriodes[prof] = 0 unless listeProfsPeriodes[prof]
	  listeProfsPeriodes[prof] += periodes.to_i

	  listeProfsMetaclasses[prof] = [] unless listeProfsMetaclasses[prof]
	  listeProfsMetaclasses[prof] << mcNom
	  listeProfsMetaclasses[prof].uniq!

	  listeMetaclassesPeriodes[mcNom] = periodes.to_i

	else
	end

      end

    file.close
#~ ------------------------------------------------
        #~ puts "$listeProfsFoyers(#{$listeProfsFoyers.class}) = #{$listeProfsFoyers.class}"
    #~ exit
#~ ---------------------------------------------
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
    listeProfs.each{|prof| listeChevauchent << prof if listeProfsCycle[prof] == "0"}

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
    listeMetaclassesFoyers.sort_by{|_key,value| _key} # class� par ordre aphab�tique metaclasses
    listeMetaclassesProfs.sort_by{|_key,value| _key} # class� par ordre aphab�tique metaclasses
    listeMetaclassesPeriodes.sort_by{|_key,value| _key} # class� par ordre aphab�tique metaclasses
    listeFoyersMetaclasses.sort_by{|_key,value| _key} # class� par ordre de foyers
    listeProfsFoyers.sort_by{|_key,value| _key} # class� par ordre de foyers
    listeProfsPeriodes.sort_by{|_key,value| _key} # class� par ordre de profs
  end



end #class
