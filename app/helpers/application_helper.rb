module ApplicationHelper

  def obtenirMetaclasses
    Metaclass.all.order(:status, :nom)
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
    
    style = "line-height:25px;background-color:#{back};color:#{color};font-weight:#{bold};font-style:#{italic};"
    
    return style, status, color = "blue"
    
  end


  def changerStatus(txt)
    #~ mc = obtenirMetaclasses
    puts txt
    #~ puts mc.nom
    #~ if mc.status = "4-en_traitement"
    #~ mc.status = "inactif"
    #~ mc.save
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


end
