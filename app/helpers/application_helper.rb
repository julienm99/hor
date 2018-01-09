module ApplicationHelper

  def satutColor(mc)
    #~ "gray"  # default
    #~ "blue"  if mc.Fixhor?
    #~ "green" if mc.fixCedulables
    #~ "red"   if mc.checked  
puts "mc.fixHor = #{mc.nom}"    
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
	  niveau = ""
	  
	  mc = Metaclass.create(
		    nom: nom, 
		    fixHor: false, 
		    fixCedulables: false, 
		    checked: false,
		    niveau: niveau, 
		    listeActivites: listeActivites
		    )
		    
	when "Classe" 
	  nom, reste = reste.split("\t")
	  cours, groupe, periodes, periodesTache, semestre, prof, salle, listeFoyers.strip = reste.split(";")
	  
	  activite = Activite.create(
		    nom: nom, 
		    nomMc: mc.nom, 
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
		    s
	  niv = listeFoyers[2,1]
	  mc.niveau = "S" + niv
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
