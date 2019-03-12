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

  def valide
    nbLignesFiliere(derniereFiliereDuDir(listHor13($repCedulables))) > 0
  end


  def msgOperationValider(executionSansErreur)
    executionSansErreur ? flash[:notice] = "Execution de [VALIDER]: REUSSIE" : flash[:notice] = "ERREUR de fonctionnement "
    flash[:notice] += " ---> CEDULABLES [ #{nbLignesDerniereFiliere(@repCedulables)}]" if executionSansErreur && valide
    flash[:notice] += " mais --->  PAS DE SOLUTION" if executionSansErreur && !valide
  end


  def effacer_DerniereFiliere(repertoire)
    File.delete(derniereFiliereDuDir(listHor13(repertoire)))
  end


  def changerStatus(mc,status)
    $listeMetaclassesEtat[mc] = status
  end


  def deSelectionner(statut)    
    $listeMetaclassesEtat.each{|mc,etat|$listeMetaclassesEtat[mc] = "inactif" if etat == statut}
  end
  

  def save_MetaclassesEnTraitement
    #~ mcEnJeu = []
    mcEnJeu = ""
    #~ $listeMetaclassesEtat.each{|mc,etat| mcEnJeu << mc if etat == "4-en_traitement" }
    $listeMetaclassesEtat.each{|mc,etat| mcEnJeu +=  " " + mc if etat == "4-en_traitement" }
    #~ open("public/4-en_traitement.txt", "w"){|f| f.puts "4-en_traitement::#{mcEnJeu.join(",")}"}
    open("public/4-en_traitement.txt", "w"){|f| f.puts "4-en_traitement::"+mcEnJeu.strip!}
    return mcEnJeu
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
    $listeMetaclassesEtat.each{|mc, etat| $listeMetaclassesEtat[mc]= "inactif"}
  end


  def statusMetaclasse(mc)
    case $listeMetaclassesEtat[mc]
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
       i  > 9 ? ajout = "" : ajout = "0" # si condition ? vrai : faux
       niv == "S1" ? gr ="Gr#{niv[1,1] + ajout + i.to_s}" : gr ="Gr#{niv[1,1] + i.to_s}"
  end


  def saveStatusMetaclassesParNom(mcEnJeu, status)
    mcEnJeu.each{|mc| $listeMetaclassesEtat[mc]=status} if mcEnJeu[0]
  end


  def obtenirIntervalleDerniereFiliereValider(diviseur)
    nbLignes = nbLignesFiliere(derniereFiliereDuDir(listHor13($repCedulables)))
    (nbLignes.to_i / diviseur).to_s
  end


  def filtrerMatiereChoisie(metaclasses, metaclassesChoisies = [], matiere)
      metaclasses.each{|mc| metaclassesChoisies << mc if mc[0,3] == matiere; puts mc }
  end


  def matieresDesMetaclasses(metaclasses, matieres)
      #~ metaclasses.each{|mc| matieres << mc.nom[0,3] }
      metaclasses.each{|mc| matieres << mc[0,3] }
      matieres.uniq!
  end

   
  def infoDesCedulables
    fname = derniereFiliereDuDir(listHor13($repCedulables)) 
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


  def updateStatusMetaclasses 
    updateCedulables      
    updateHoraires
  end


  def updateCedulables
    mcCedulables = infoDesCedulables
    
    $listeMetaclasses.each do |mc|
      unless $listeMetaclassesEtat[mc]=="inactif" || $listeMetaclassesEtat[mc]=="4-en_traitement" then
	$listeMetaclassesEtat[mc] = "inactif" 
      end
    end
    saveStatusMetaClasses(mcCedulables, "3-cedulables") unless mcCedulables == "start" 
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
