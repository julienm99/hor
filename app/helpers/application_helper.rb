module ApplicationHelper

  def obtenirToutesLesMetaclasses
    Metaclass.all.order(:status, :nom) 
  end


  def metaclasses(sujet)
    liste = []
    obtenirToutesLesMetaclasses.each do |mc|
      case sujet
      when "backbone"
	liste << mc if %w[EPS ART OPT ANG CHI PHY FM5].include?(mc.nom[0,3])
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
  
   
  def info(horaireTemp)
    files = Dir.glob("/home/julienm/hor13/op/cedulables/*").sort
    fname = files.last         
    
    file = File.open(fname, "r:iso8859-1")    
      line = file.gets       # prendre que la première ligne
      variance, horaireTemp = line.split("\t")
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
  

  def saveNomsMetaclasses(status)
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


  def changerMetaclassesEnTraitement_pourCedulables
    metaclasses("4-en_traitement").each{|mc| mc.status = "3-cedulables" ; mc.save}    
  end


  def restaurerMetaclasses(status)
    mcNomEnJeu = []
    file = File.open("public/#{status}.txt", "r:iso8859-1")
      type, str = file.gets.split("::")
      str.strip!
      mcNomEnJeu = str.split(",")
    file.close
    saveStatusMetaclassesParNom(mcNomEnJeu, status)	  
  end
	
  def updateStatusMetaclasses
    
    %w[1-horaire_fixe 2-cedulables_fixe 3-cedulables 4-en_traitement].each do |status|
      
      mcNomEnJeu = []
      file = File.open("public/#{status}.txt", "r:iso8859-1")
	case status
	when "1-horaire_fixe" 
	  while (line = file.gets)
	    type, reste = line.split("::")
	    if type.strip == "Horaire" then
	      mcNom,  horaire = reste.split("\t")
	      mcNom = mcNom.strip
	      mcNomEnJeu << mcNom unless mcNomEnJeu.include?(mcNom)
	    end
	  end
	  
	when "2-cedulables_fixe", "3-cedulables", "4-en_traitement"
	  line = file.gets
	  type, mcNoms = line.split("::")
	  mcNoms = mcNoms.strip
	  mcNomEnJeu = mcNoms.split(",") unless mcNoms = ""
	
	else
	end
	
      file.close
      saveStatusMetaclassesParNom(mcNomEnJeu, status)
    end
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


  def filtrerMatiereChoisie(metaclasses, metaclassesChoisies = [], matiere)
      metaclasses.each{|mc| metaclassesChoisies << mc if mc[0,3] == matiere; puts mc }
  end


  def matieresDesMetaclasses(metaclasses, matieres)
      metaclasses.each{|mc| matieres << mc.nom[0,3] }
      matieres.uniq!
    end
    

  def miseAjourMetaclasses
    fname = "public/metaclasses.txt"
    file = File.open(fname, "r:iso8859-1")
    
      while (line = file.gets)
	type, reste = line.split("::")
	
	case type.strip
	when "MetaClasse" 
	  nom, listeActivites = reste.split("\t")
	  listeActivites = listeActivites[7,listeActivites.length].strip
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


end
