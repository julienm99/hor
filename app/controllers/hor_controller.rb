class HorController < ApplicationController

  def index        # les listes sont des variables globales(): elles servent de base de données

    paramsAutorises

    $path = ENV["GOBIT_DATA"]

    fmetas  = "#{$path}/init/metas.txt"
    fprofs  = "#{$path}/init/profs.txt"
    ffoyers = "#{$path}/init/foyers.txt"
    fsalles = "#{$path}/init/salles.txt"

    $metasTxt,$listeMetas,$listeMetasEtat,$listeMetasPeriodes,
    $listeProfs,$listeFoyers,$listeSalles,
    $listeMetasFoyers,$listeMetasProfs,$listeFoyersMetas,
    $listeNiveauxFoyers,$listeProfsFoyers,
    $listeProfsCycle,$listeProfsPeriodes,$listeProfsMetas = obtenirLesListes(
    fmetas,  $metasTxt={}, $listeMetas=[], $listeMetasEtat={}, $listeMetasPeriodes={},
    fprofs,  $listeProfs=[],
    ffoyers, $listeFoyers=[],
    fsalles, $listeSalles=[], 
    
      $listeMetasFoyers={},
      $listeMetasProfs={},
      $listeFoyersMetas={},
      $listeNiveauxFoyers={},
      $listeProfsFoyers={},
      $listeProfsCycle={},
      $listeProfsPeriodes={},
      $listeProfsMetas={}
		  )
     

    #$listeMetasProfs.each{|mc,prof| $listeChevauchent -= prof if mc[0,3] == "EPS"}
    # puts "$metasTxt(#{$metasTxt.class}) = #{$metasTxt}"
    # puts "$listeMetas(#{$listeMetas.class}) = #{$listeMetas}"
    # puts "$listeMetasEtat(#{$listeMetasEtat.class}) = #{$listeMetasEtat}"
    # puts "$listeMetasPeriodes(#{$listeMetasPeriodes.class}) = #{$listeMetasPeriodes}"
    #~ puts "$listeProfsMetaclasses(#{$listeProfsMetaclasses.class}) = #{$listeProfsMetaclasses}"
    #~ puts "$listeMetasPeriodes(#{$listeMetasPeriodes.class}) = #{$listeMetasPeriodes}"
    #~ puts "$listeChevauchent(#{$listeChevauchent.class}) = #{$listeChevauchent}"
    #~ exit

    @mc = $listeMetas  # variables �quivalentes
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
    mc = $listeMetasEtat

    mc[@mcTraitee]=="inactif" ? mc[@mcTraitee]="4-en_traitement" : mc[@mcTraitee]="inactif"

    blocMetaclasses
   end


  def blocMetaclasses
    @blocMC = params[:blocMC]
    @execute = params[:execute]
    @mc = metaclasses(@blocMC)
    @mc = $listeMetas unless @blocMC
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
    @transfert_PAS  = params[:transfert_PAS]  # PAS : site web "Planification Année Scolaire"
    @segment        = params[:segment]  
    @jour           = params[:jour]  
    @maxSols        = params[:maxSols]  
    @actif          = params[:actif] 
    @ceduler        = params[:ceduler]
   end




 
  def metaclasses(sujet)

    liste = []
    $listeMetas.each do |mc|
      case sujet
      when "backbone"
	      liste << mc if %w[EPS ART OPT ANG CHI PHY FM5 MON].include?(mc[0,3])
	      liste << mc if %w[MAT5 FRA5].include?(mc[0,4])

      when /niveauS/
	      $listeNiveauxFoyers[sujet[6,2]].each do |gr|
	        liste << mc if $listeMetasFoyers[mc].include?(gr)
	      end
	      liste.uniq!

      when /Gr/
	      liste << mc if $listeMetasFoyers[mc].include?(sujet)

      when "MON"
	      liste << mc unless /MON/.match(mc) == nil

      when "ANG"
	      liste << mc if %w[ANG ESL ELA EES].include?(mc[0,3])

      when "HIS"
	      liste << mc if %w[HIS HQC MON].include?(mc[0,3])

      when "4-en_traitement"
	      liste << mc if $listeMetasEtat[mc] == sujet

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


  def obtenirLesListes(	
    fmetas,  metasTxt, listeMetas, listeMetasEtat, listeMetasPeriodes,
    fprofs,  listeProfs,
    ffoyers, listeFoyers,
    fsalles, listeSalles,

    listeMetasFoyers, listeMetasProfs,
    listeFoyersMetas,
    listeNiveauxFoyers,
    listeProfsFoyers, listeProfsCycle, listeProfsPeriodes, listeProfsMetas
    )

    f = File.open(fmetas, "r:iso8859-1")
      while (line = f.gets)
	      mcNom,cycle,sem,periodes,reste = line.split(";")
        metasTxt[mcNom] = line.strip.split(";")
        listeMetas << mcNom
        listeMetasEtat[mcNom] = "inactif" # au départ: toutes les metaclasses sont inactives
        listeMetasPeriodes[mcNom] = periodes
      end
      f.close  

    f = File.open(fprofs, "r:iso8859-1")
      while (line = f.gets)
	      type,reste = line.split("::")
        nom,rest = reste.split("\t")
        listeProfs << nom
      end
      f.close  

    f = File.open(ffoyers, "r:iso8859-1")
      while (line = f.gets)
	      type,reste = line.split("::")
        foyer,rest = reste.split("\t")
        listeFoyers << foyer
      end
      f.close  

      f = File.open(fsalles, "r:iso8859-1")
      while (line = f.gets)
	      type,reste = line.split("::")
        salle,rest = reste.split("\t")
        listeSalles << salle
      end
      f.close 

      metasTxt.each do |mcNom,value|
        listeMetasFoyers[mcNom] = listeMetasProfs[mcNom]= []

        listeFoyers.each{|foyer| (listeMetasFoyers[mcNom] << foyer) if value.include?(foyer)}
        listeMetasFoyers[mcNom].uniq! if listeMetasFoyers[mcNom]

        listeProfs.each{|prof| (listeMetasProfs[mcNom] << prof) if value.include?(prof)} 
        listeMetasProfs[mcNom].uniq!

        listeProfs.each do |prof| 
          listeProfsFoyers[prof] = []
          listeFoyers.each {|foyer| (listeProfsFoyers[prof] << foyer) if (value.include?(foyer) && value.include?(prof))} 
          listeProfsFoyers[prof].uniq!
        end              
      end 

      listeProfs.each do |prof|
        listeProfsMetas[prof] = []
        metasTxt.each {|mcNom,value| listeProfsMetas[prof] << mcNom if value.include?(prof)}
        listeProfsMetas[prof].uniq!
      end

      %w[S1 S2 S3 S4 S5].each do |niv|
        listeNiveauxFoyers[niv] = []
        listeFoyers.each {|foyer| listeNiveauxFoyers[niv] << foyer if (foyer[2,1] == niv[1,1])}
      end

        
          


   #~ ------------------------------------------------
   #~ puts "$listeProfsFoyers(#{$listeProfsFoyers.class}) = #{$listeProfsFoyers.class}"
    #~ exit
   #~ ---------------------------------------------
    #listeFoyers.flatten!.uniq!.sort!
    #listeProfsFoyers.each do |prof,foyers|
	  #  cycle = []
	  #  foyers.each do |gr|
	  #  cycle << "1" if  gr[2]=="1" || gr[2]=="2"
	  #  cycle << "2" if  gr[2]=="3" || gr[2]=="4" || gr[2]=="5"
	  #end
	 #cycle.uniq!
	 #listeProfsCycle[prof]= "1" if cycle[0] == "1"
	 #listeProfsCycle[prof]= "2" if cycle[0] == "2"
	 #listeProfsCycle[prof]= "0" if cycle.size == 2
    #   end
    #~ ---------------------------------------------
    #~ liste_PROFS_QUI_CHEVAUCHENT sans[EPS] ProfsCycle = "0" (0 prof qui enseigne aux 2 cycles) - EPS
    #listeProfs.uniq!.sort!
    #listeProfs.each{|prof| listeChevauchent << prof if listeProfsCycle[prof] == "0"}

    #%w[1 2 3 4 5].each{|niv|listeNiveauxFoyers["S"+niv]=[]} # d�finir les �l�ments du hash comme array []
    #listeFoyers.each{|gr|listeNiveauxFoyers["S"+gr[2]]<< gr unless gr[0]=="P"}   # exemple: dans Gr14 le 1( 3e lettre)signifie @niveauS1

    #listeMetaclassesFoyers.each do|mc,foyers|
    #  foyers.each do |gr|
	 #listeFoyersMetaclasses[gr]  = [] if listeFoyersMetaclasses[gr] == nil
	 #listeFoyersMetaclasses[gr] << mc
   #   end
    #end

    listeMetas.sort!
    listeMetasEtat.sort_by{|_key,value| _key} # classé par ordre aphabétique de metaclasses
    listeMetasFoyers.sort_by{|_key,value| _key} 
    listeMetasProfs.sort_by{|_key,value| _key} 
    listeMetasPeriodes.sort_by{|_key,value| _key} 
    listeFoyersMetas.sort_by{|_key,value| _key} 
    listeProfsFoyers.sort_by{|_key,value| _key} 
    listeProfsMetas.sort_by{|_key,value| _key} 

    return  metasTxt,listeMetas,listeMetasEtat,listeMetasPeriodes,listeProfs,listeFoyers,listeSalles,
            listeMetasFoyers,listeMetasProfs,listeFoyersMetas,listeNiveauxFoyers,listeProfsFoyers,
            listeProfsCycle,listeProfsPeriodes,listeProfsMetas
  end

end #class
