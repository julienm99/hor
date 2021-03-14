module ApplicationHelper

require 'fileutils'

  def dirHor13(repertoire)
    "/home/julienm/hor13/#{repertoire}"
  end


  def listHor13(repertoire)
    dirHor13(repertoire)+"/*"
  end


  def listHor13Alpha(repertoire)
    Dir[listHor13(repertoire)].sort {|a,b| a <=> b}
  end


  def derniereFiliereDuDir(repertoire)   #derni�re fili�re modifi�e
    Dir.glob(repertoire).sort {|a,b| File.mtime(a) <=> File.mtime(b)}.last
  end


  def nbLignesDerniereFiliere(repertoire)
    nbLignesFiliere(derniereFiliereDuDir(listHor13(repertoire)))
  end


  def nbLignesFiliere(filiere)
    File.readlines(filiere).size
  end 


  def valide
    nbLignesFiliere(derniereFiliereDuDir(listHor13($dirCedulables))) > 0
  end


  def filiere(repertoire)
    repFiliere = derniereFiliereDuDir(listHor13(repertoire)) 	# chemin complet de la fili�re
    nbLignes = nbLignesFiliere(repFiliere)			# nombre de lignes de la fili�re
    nomFiliere = repFiliere.split("/").last			# nom de la fili�re sans son chemin
    
    return repFiliere,nbLignes,nomFiliere
  end


  def effacer_DerniereFiliere(repertoire)
    File.delete(derniereFiliereDuDir(listHor13(repertoire)))
  end


  def changerMetaclasseEtat(mc,etat)
    $listeMetaclassesEtat[mc] = etat
  end


  def deSelectionner    
    $listeMetaclassesEtat.each{|mc,etat|$listeMetaclassesEtat[mc] = "inactif" if etat == "4-en_traitement"}
  end
  

  def save_MetaclassesEnTraitement
    mcEnJeu = "4-en_traitement::"
    $listeMetaclassesEtat.each{|mc,etat| (mcEnJeu +=  " " + mc) if etat == "4-en_traitement" }
    file = File.open("public/4-en_traitement.txt", "w")
      file.puts mcEnJeu.strip
    file.close
    return mcEnJeu
  end


  def obtenirMetaclassesEtat(etat)
    file = File.open("public/#{etat}.txt", "r:iso8859-1") 
      line = file.gets 
      if line.length > 19 then # file n'est pas vide
        type, reste = line.split("::")
        metaclasses = reste.split(" ")
      else
        metaclasses=""
      end
    file.close
    return metaclasses
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


  def styleMatiereEtat(etat)
    case etat
    when "actif"
      color = "white"; bold="bold"; italic="italic"; back = "red"
      
    when "inactif"
      color = "gray"; bold="normal"; italic="normal"; back = "white"
      
    when "boutonDiago"
      color = "white"; bold="bold"; italic="italic"; back = "Green"
    else
    end
    
    style  = "line-height: 25px; background-color: #{back}; color: #{color};"
    style += "font-size:20px; font-weight:#{bold}; font-style:#{italic};"
    style += "border-radius:5px;"
    
    return style
  end


  def group_string(niv,i)
       i  > 9 ? ajout = "" : ajout = "0" # si condition ? vrai : faux
       niv == "S1" ? gr ="Gr#{niv[1,1] + ajout + i.to_s}" : gr ="Gr#{niv[1,1] + i.to_s}"
  end


  def obtenirIntervalle(diviseur)
    nbLignes = nbLignesFiliere(derniereFiliereDuDir(listHor13($dirCedulables)))
    (nbLignes.to_i / diviseur).to_s
  end


  def obtenirListeProfsFinTache
    profsFinTache = [] ; profsEnjeu = [] ; mcEnjeu = []
    
      $listeMetaclassesEtat.each do |mc,etat|
	    mcEnjeu << mc if etat=="1-horaire_fixe" || etat=="3-cedulables"
	  end
	    
      $listeMetaclassesEtat.each do |mc,etat|
	    profsEnjeu << $listeMetaclassesProfs[mc] if etat=="3-cedulables"
	  end    
      profsEnjeu.flatten!.uniq!
      
      $listeProfsMetaclasses.each{|prof,mc| profsFinTache << prof.capitalize unless (mc-mcEnjeu).any?}
    
    return profsFinTache
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
      line = file.gets       # prendre que la premi�re ligne
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
    fname = derniereFiliereDuDir(listHor13($dirCedulables)) 
    obtenirMetaclassesCedulables(fname)
  end


  def obtenirMetaclassesCedulables(fname)
    mcCedulables = metaclasses = []
    
    file = File.open(fname, "r:iso8859-1")    
      line = file.gets       # prendre que la premiere ligne
    file.close 
    if line == nil then      #filière (ex.504.ceds) vide? si oui effacer et prendre la précédente (503.ceds)
      File.delete(fname)
      fname[-7,2].to_i < 11 ? (fname[-7,2]="0"+(fname[-7,2].to_i-1).to_s) : (fname[-7,2]=(fname[-7,2].to_i-1).to_s)
    end

    file = File.open(fname, "r:iso8859-1")    
      line = file.gets                # prendre que la premiere ligne
      unless line.strip =="nil" then  # "nil" filière de départ sans métaclasses
        variance, reste = line.split("\t") 
        mcCedulables = reste.split(",")
        #~ mcCedulables a la forme [ANG19,D1E3F5,MAT15,A1B2C3H6,...] on ne veut que les metaclasses
        (0..mcCedulables.size).each{|x| metaclasses<< mcCedulables[x]if x.even?} if mcCedulables[0]
        metaclasses.delete_at(metaclasses.size-1) # Dernier element n'est pas une metaclasse
      end
    file.close 
    return metaclasses
  end


  def obtenirCedulablesHoraire
    fname = derniereFiliereDuDir(listHor13($dirCedulables)) 
    
    file = File.open(fname, "r:iso8859-1")    
      line = file.gets       # prendre que la premi�re ligne
      unless line.strip == nil || line.strip =="nil" then
	      variance, metaclasses = line.split("\t") 
      end
    file.close 
    
    return metaclasses
  end
  
  
  def obtenirFileLigne_1(fname)
    file = File.open(fname, "r:iso8859-1")    
      line = file.gets       # prendre que la premi�re ligne
      unless line.strip == nil || line.strip =="nil" then
	      variance, metaclasses = line.split("\t") 
      end
    file.close 
    return metaclasses.strip
  end


  def obtenir_OrdreSize(repertoire)
     Dir.glob(listHor13(repertoire)).sort{|a,b| File.size(a) <=> File.size(b)} 
  end
 
 
  def obtenir_OrdreSizeNiv(niv,f_ordreSize)
    f_ordreSizeNiv = []
    f_ordreSize.each{|fname| f_ordreSizeNiv << fname if fname[fname.size-13,2] == niv}
    return f_ordreSizeNiv
  end
 
 
  def ordonner_FileJoursDiagoSelonSize(f_ordreSizeNiv)
    ordreJoursDiago = []
    f_ordreSizeNiv.each{|fname| ordreJoursDiago << fname[fname.size-1,1]}
    jourDepart = ordreJoursDiago[0]		# jour de la fili�re la plus petite
    ordreJoursDiago << "Z"  			# marque du dernier jour (avant le Z)
    ordreJoursDiago = ordreJoursDiago.drop(1) 	# ordre des jours � diagonaliser
    
    return jourDepart, ordreJoursDiago
  end
 
 
  def obtenirOrdreDesJours(niv)
    f_ordreSize    = obtenir_OrdreSize("op/compact")
    f_ordreSizeNiv = obtenir_OrdreSizeNiv(niv,f_ordreSize)
    jourDepart, ordreJoursDiago = ordonner_FileJoursDiagoSelonSize(f_ordreSizeNiv)
    
    return jourDepart, ordreJoursDiago
  end
  

  def obtenirCompact(niv,jour)
    fname = dirHor13("op/compact/#{niv}_compact.j#{jour}")         
    return obtenirFileLigne_1(fname)
  end  


  def obtenir_MatieresNiveau(niv)
    matieresNiv = mc = [] 
    %w[A B C D E F G H].each do |jour| 
      mc = obtenirCompact(niv,jour).strip.split(",")
      (0..mc.size-1).each{|x| matieresNiv << mc[x][0,3] if x.even?} 
    end
    return matieresNiv.uniq! 
  end  


  def obtenir_matieresFiltre(matieresEtat)
    matieresFiltre = []
    matieresEtat.each {|m,etat| matieresFiltre << m if matieresEtat[m] == "actif" }
    return matieresFiltre.join(",") 
  end  


  def obtenirDiag(niv,jour)
    fname = dirHor13("op/diag/#{niv}_diag.j#{jour}")         
    return obtenirFileLigne_1(fname)
  end  


  def save_MetaclassesEtat(mcEnJeu, etat)
      mcEnJeu.each{|mc| $listeMetaclassesEtat[mc] = etat} if mcEnJeu[0]
  end
  


end # Module ApplicationHelper
