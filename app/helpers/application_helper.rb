module ApplicationHelper

require 'fileutils'

  def dirHor13(repertoire)
    "/home/julienm/hor13/#{repertoire}"
  end


  def listHor13(repertoire)
    dirHor13(repertoire)+"/*"
  end


  def derniereFiliereDuDir(repertoire)   #dernière filière modifiée
    Dir.glob(repertoire).sort {|a,b| File.mtime(a) <=> File.mtime(b)}.last
  end


  def nbLignesDerniereFiliere(repertoire)
    nbLignesFiliere(derniereFiliereDuDir(listHor13(repertoire)))
  end


  def nbLignesFiliere(filiere)
    File.readlines(filiere).size
  end


  def obtenirToutesLesMetaclasses
    Metaclass.all.order(:status, :nom) 
  end


  def obtenirToutesLesActivites
    Activite.all.order(:nom) 
  end


  def metaclasses(sujet)
    liste = []
    obtenirToutesLesMetaclasses.each do |mc|
      case sujet
      when "backbone"
	liste << mc if %w[EPS ART OPT ANG CHI PHY FM5 MON].include?(mc.nom[0,3])
	liste << mc if %w[MAT4].include?(mc.nom)
	
      when /nivS/
	liste << mc if mc.nom[3,1] == sujet[4,1]
      
      when "4-en_traitement", "3-cedulables"
	liste << mc if mc.status == sujet

      else 
	liste << mc if mc.nom[0,3] == sujet

      end
      
    end
    return liste
  end
  
   


  def valide
    nbLignesFiliere(derniereFiliereDuDir(listHor13("op/cedulables"))) > 0
  end


  def msgOperationValider(executionSansErreur)
    #~ flash[:notice] = "ERREUR de fonctionnement " unless executionSansErreur
    #~ flash[:notice] = "Execution de [VALIDER]: REUSSIE" if executionSansErreur
    executionSansErreur ? flash[:notice] = "Execution de [VALIDER]: REUSSIE" : flash[:notice] = "ERREUR de fonctionnement "
    flash[:notice] += " ---> CEDULABLES [ #{nbLignesDerniereFiliere("op/cedulables")}]" if executionSansErreur && valide
    flash[:notice] += " mais --->  PAS DE SOLUTION" if executionSansErreur && !valide
  end


  def effacer_DerniereFiliere(repertoire)
    File.delete(derniereFiliereDuDir(listHor13(repertoire)))
  end


  def infoDesCedulables
    fname = derniereFiliereDuDir(listHor13("op/cedulables")) 
    file = File.open(fname, "r:iso8859-1")    
      line = file.gets       # prendre que la première ligne
      variance, horaireTemp = line.split("\t") if line.strip != nil
    file.close   
    return variance, horaireTemp
  end


  def changerStatus(mc,status)
    mc.status = status
    mc.save
  end


  def deSelectionner(statut)    
    Metaclass.all.order(:status, :nom).each do |mc|      
      if mc.status == statut then
	 mc.status = "inactif" ; mc.save  
      end
    end
  end
  

  def save_NomsMetaclasses(status)
    mcEnJeu = []
    metaclasses(status).each{|mc| mcEnJeu << mc.nom }
    open("public/#{status}.txt", "w"){|f| f.puts "#{status}::#{mcEnJeu.join(",")}"}
  end


  def obtenirNomsMetaclasses(status)
    file = File.open("public/#{status}.txt", "r:iso8859-1")
      line = file.gets
      type, nomsMetaclasses = line.split("::")
    file.close
    return nomsMetaclasses.strip
  end


  def restaurerMetaclasses(status)
      mcNomEnJeu = []
      file = File.open("public/#{status}.txt", "r:iso8859-1")
	type, mcNoms = file.gets.split("::")
	mcNoms.strip! if mcNoms
	mcNomEnJeu = mcNoms.split(",") if mcNoms
      file.close
      saveStatusMetaclassesParNom(mcNomEnJeu, status)	  
  end
	
  def mettreTousLesStatusInactif 
    obtenirToutesLesMetaclasses.each{|mc| mc.status = "inactif"; mc.save }
  end


  def statusMetaclasse(mc)
    case mc.status
    when "1-horaire_fixe"
      color = "blue"; bold="bold"; italic="italic"; back = "yellow"
      status = " checked disabled"
      
    when "2-cedulables_fixe"
      color = "white"; bold="bold"; italic="italic"; back = "Green"
      status = " checked disabled"
      
    when "3-cedulables"
      color = "white"; bold="bold"; italic="italic"; back = "MediumSeaGreen"
      status = " checked disabled"
      
    when "4-en_traitement"
      color = "white"; bold="bold"; italic="italic"; back = "red"
      status = " checked"
      
    when "inactif"
      color = "gray"; bold="normal"; italic="normal"; back = "white"
      status = ""
      
    else
    end
    
    style  = "line-height: 25px; background-color: #{back}; color: #{color};"
    style += "font-size:20px; font-weight:#{bold}; font-style:#{italic};"
    style += "border-radius:5px;"
    
    return style, status
  end


  def group_string(niv,i)
       i  > 9 ? ajout = "" : ajout = "0" 
       niv == "S1" ? gr ="Gr#{niv[1,1] + ajout + i.to_s}" : gr ="Gr#{niv[1,1] + i.to_s}"
  end


  def saveStatusMetaclassesParNom(mcNomEnJeu, status)
    mcNomEnJeu.each{|nom| mc = Metaclass.find_by_nom(nom); mc.status = status; mc.save } if mcNomEnJeu[0]
  end


  def obtenirIntervalleDerniereFiliereValider(diviseur)
    nbLignes = nbLignesFiliere(derniereFiliereDuDir(listHor13("op/cedulables")))
    (nbLignes.to_i / diviseur).to_s
end


  def filtrerMatiereChoisie(metaclasses, metaclassesChoisies = [], matiere)
      metaclasses.each{|mc| metaclassesChoisies << mc if mc[0,3] == matiere; puts mc }
  end


  def matieresDesMetaclasses(metaclasses, matieres)
      metaclasses.each{|mc| matieres << mc.nom[0,3] }
      matieres.uniq!
  end

  def creerBaseDeDonnees
    fname = "public/metaclasses.txt"
    file = File.open(fname, "r:iso8859-1")
    
      while (line = file.gets)
	type, reste = line.split("::")
	
	case type.strip
	when "MetaClasse" 
	  nom, listeActivites = reste.split("\t")
	  listeActivites = listeActivites[14,listeActivites.length].strip
	  niveau = "" ; status ="inactif"
	  
	  mc = Metaclass.create(
	      nom: nom, 
	      status: status, 
	      niveau: niveau, 
	      listeActivites: listeActivites
	      )		    
	when "Classe" 
	  nom, reste = reste.split("\t")
	  cours, groupe, periodes, periodesTache, semestre, prof, salle, list = reste.split(";")
	  listeFoyers = list.strip
	  
	  activite = Activite.create(
		    nom: nom, 
		    identifiantmc: mc.nom, 
		    cours: cours, 
		    groupe: groupe, 
		    periodes: periodes, 
		    periodesTache: periodesTache, 
		    semestre: semestre, 
		    prof: prof, 
		    salle: salle, 
		    listeFoyers: listeFoyers,
		    metaclass: mc
		    )		    
	  mc.niveau = "S" + listeFoyers[2,1]
	  mc.save
	else	    
	end	  
      end 
    file.close	        
  end


  def infoDesCedulables
    fname = derniereFiliereDuDir(listHor13("op/cedulables")) 
    nomMetaclasses = obtenirNomMetaclasses(fname)
  end


  def infoEnTraitement
    fname = "public/4-en_traitement.txt"
    nomMetaclasses = obtenirNomMetaclasses(fname)
  end


  def obtenirNomMetaclasses(fname)
    file = File.open(fname, "r:iso8859-1")    
      line = file.gets       # prendre que la première ligne
      variance, nomsMetaclasses = line.split("\t") if line.strip != nil || line.strip !="nil"
    file.close   
    return nomsMetaclasses
  end


  def updateMetaclasses
    src = dirHor13("init/metaclasses.txt") 
    dst = "public/metaclasses.txt"
    FileUtils.cp(src, dst)
    
    Activite.delete_all
    Metaclass.delete_all
    
    creerBaseDeDonnees
    updateStatusMetaclasses
  end


  def updateStatusMetaclasses 
    updateCedulables      
    updateHoraires
  end


  def updateCedulables
    mc = obtenirToutesLesMetaclasses # Vider la bases de données ne garder que le statut fixé
    mc.each do |metaclass|
      unless metaclass.status == "1-horaire_fixe" || metaclass.status == "4-en_traitement" then
	metaclass.status = "inactif"
	metaclass.save
      end
    end
    mc_cedulables = infoDesCedulables
    saveStatusMetaClasses(mc_cedulables, "3-cedulables")  
  end


  def updateHoraires
    mcNomEnJeu = []
    
    file = File.open(dirHor13("data/horaires.txt"), "r:iso8859-1")    
      while (line = file.gets)
	type, reste = line.split("::")
	if type.strip == "Horaire" then
	  mcNom, horaire = reste.split("\t")
	  mcNom.strip!
	  mcNomEnJeu << mcNom unless mcNomEnJeu.include?(mcNom)
	end
      end
    file.close
    saveStatusMetaclassesParNom(mcNomEnJeu, "1-horaire_fixe")  
  end


  def saveStatusMetaClasses(nomMC, status)
    if nomMC then
      mcNomEnJeu = [] # Cédulables de la dernière filière et les mettre dans la base de données
      nomMC.strip! ; a = nomMC.split(",") 
      Hash[*a].each{|k,v| mcNomEnJeu << k} 
      saveStatusMetaclassesParNom(mcNomEnJeu, status)
    end    
  end


end
