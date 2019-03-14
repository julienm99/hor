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
    puts "file(#{filiere.class}) = #{filiere}"
    File.readlines(filiere).size
  end 


  def valide
    nbLignesFiliere(derniereFiliereDuDir(listHor13($repCedulables))) > 0
  end


  def msgOperationValider(executionSansErreur)
    filiere = derniereFiliereDuDir(listHor13(@repCedulables))
    nbLignes = filiere.size
    
    executionSansErreur ? flash[:notice] = "Execution [VALIDER]: REUSSIE" : flash[:notice] = "ERREUR de fonctionnement "
    flash[:notice] += " ---> CEDULABLES [#{filiere}: #{nbLignes} lignes]" if executionSansErreur && valide
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
    mcEnJeu = ""
    $listeMetaclassesEtat.each{|mc,etat| mcEnJeu +=  " " + mc if etat == "4-en_traitement" }
    open("public/4-en_traitement.txt", "w"){|f| f.puts "4-en_traitement::"+mcEnJeu.strip!}
    return mcEnJeu
  end


  def obtenirMetaclassesEtat(etat)
    file = File.open("public/#{etat}.txt", "r:iso8859-1")
      line = file.gets
      type, reste = line.split("::")
      metaclasses = reste.split(" ")
    file.close
    return metaclasses
  end


  def restaurerMetaclasses(status)
      mcNomEnJeu = []
      file = File.open("public/#{status}.txt", "r:iso8859-1")
	type, mcNoms = file.gets.split("::")
	mcNoms.strip! if mcNoms
	mcNomEnJeu = mcNoms.split(",") if mcNoms
      file.close
      save_MetaclassesEtat(mcNomEnJeu, status)	  
  end


  def mettreMetaclassesEtat_inactif 
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


  def obtenirIntervalleDerniereFiliereValider(diviseur)
    nbLignes = nbLignesFiliere(derniereFiliereDuDir(listHor13($repCedulables)))
    (nbLignes.to_i / diviseur).to_s
  end


  def filtrerMatiereChoisie(metaclasses, metaclassesChoisies = [], matiere)
      metaclasses.each{|mc| metaclassesChoisies << mc if mc[0,3] == matiere; puts mc }
  end


  def matieresDesMetaclasses(metaclasses, matieres)
      metaclasses.each{|mc| matieres << mc[0,3] }
      matieres.uniq!
  end

   
  def obtenirMetaclasses(fname)
    file = File.open(fname, "r:iso8859-1")    
      line = file.gets       # prendre que la première ligne
      variance, metaclasses = line.split("\t") unless line.strip == nil || line.strip =="nil"
    file.close  
    return metaclasses
  end


  def updateMetaclassesEtat
    mettreMetaclassesEtat_inactif
    
    updateEnTraitement
    updateCedulables      
    updateHoraires
  end

  def updateEnTraitement
    save_MetaclassesEtat(mcEnTraitement,"4-en_traitement") unless mcEnTraitement == NilClass 
  end


  def updateCedulables
    mcCedulables = infoDesCedulables
    save_MetaclassesEtat(mcCedulables, "3-cedulables") if mcCedulables[0] 
  end


  def updateHoraires
    mcEnJeu = []    
    file = File.open(dirHor13("data/horaires.txt"), "r:iso8859-1")    
      while (line = file.gets)
	type, reste = line.split("::")
	if type.strip == "Horaire" then
	  mcNom, horaire = reste.split("\t")
	  mcNom.strip!
	  mcEnJeu << mcNom unless mcEnJeu.include?(mcNom)
	end
      end
    file.close
    save_MetaclassesEtat(mcEnJeu, "1-horaire_fixe")  
  end


  def mcEnTraitement
    obtenirMetaclassesEtat("4-en_traitement")
  end


  def infoDesCedulables
    fname = derniereFiliereDuDir(listHor13($repCedulables)) 
    obtenirMetaclassesCedulables(fname)
  end


  def obtenirMetaclassesCedulables(fname)
    mcCedulables = metaclasses = []
    
    file = File.open(fname, "r:iso8859-1")    
      line = file.gets       # prendre que la première ligne
      variance, reste = line.split("\t") unless line.strip == nil || line.strip =="nil"
      mcCedulables = reste.split(",")
    file.close 
    
    #~ REM:  mcCedulables a la forme [ANG19,D1E3F5,MAT15,A1B2C3H6,...] on ne veut que les metaclasses
    (0..mcCedulables.size).each{|x| metaclasses<< mcCedulables[x]if x.even?} if mcCedulables[0]
    
    return metaclasses
  end


  def save_MetaclassesEtat(mcEnJeu, etat)
      mcEnJeu.each{|mc| $listeMetaclassesEtat[mc] = etat} if mcEnJeu[0]
  end
  


end # Module ApplicationHelper
