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
      
      when "4-en_traitement"
	liste << mc if mc.status == sujet

      else 	
      end
      
    end
    return liste
  end
  
   
  def info(horaireAfixer)
    files = Dir.glob("/home/julienm/hor13/op/cedulables/*").sort
    fname = files.last         
    
    file = File.open(fname, "r:iso8859-1")    
      line = file.gets       # prendre que la première ligne
    file.close
    
    variance, horaireAfixer = line.split("\t")
    
    return variance, horaireAfixer
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
  

  def sauverNomsMetaclasses(status)
    mcEnJeu = []
    metaclasses(status).each{|mc| mcEnJeu << mc.nom }
    open("public/#{status}.txt", "w"){|f| f.puts "#{status}::#{mcEnJeu.join(",")}"}
      #~ case status
      #~ when "4-en_traitement"
	
      #~ when "3-cedulables"
	#~ open("public/#{status}.txt", "w"){|f| f.puts "#{status}::#{mcEnJeu.join(",")}"}
      #~ when "2-cedulables_fixe"
      #~ when "1-horaire_fixe"
      #~ else
      #~ end      
  end


  def obtenirNomsMetaclasses(status)
    file = File.open("public/#{status}.txt", "r:iso8859-1")
      line = file.gets
      type, nomsMetaclasses = line.split("::")
    file.close
    #~ open("public/#{status}.txt", "r"){|line| type,nomsMetaclasses = line.gets.split("::")}
    puts "DEBUG nomsMetaclasses =  #{nomsMetaclasses}"; exit
    return nomsMetaclasses.strip
  end


  def changerMetaclassesEnJeu_pourCedulables
    metaclasses("4-en_traitement", liste = [])
    liste.each{|mc| mc.status = "3-cedulables" ; mc.save}
    
  end


  def updateStatusMetaclasses
    mcEnJeu = []
    
    file = File.open("public/horaires.txt", "r:iso8859-1")
    
      while (line = file.gets)
	type, reste = line.split("::")
	case type.strip
	when "Horaire" 
	  nom,  reste = reste.split("\t")
	  nom = nom.strip
	  mcEnJeu << nom unless mcEnJeu.include?(nom)
	else
	  
	end
      end
    file.close
    
    mcEnJeu.each{|nom| mc = Metaclass.find_by_nom(nom); mc.status = "1-horaire_fixe"; mc.save }
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
