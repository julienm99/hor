module ApplicationHelper

  def lire(metaclasses)
      File.open("public/metaclasses.txt").each do |line|  
	    id, reste = line.split("\t")  
	    metaclasses << id[12,id.size] if id[0,12] == "MetaClasse::" 
	    metaclasses.sort!
      end  
  end

  def lire_metaclasses_txt
      fname = "public/metaclasses.txt"
      file = File.open(fname, "r:iso8859-1")
	while (line = file.gets)
	  type, reste = line.split("::") 
	  nom, reste = reste.split("\t") if reste.class != NilClass
	  case type.strip 
	  when "MetaClasse" 
	    puts "Metaclasse : #{nom}"
	    #~ Metaclass.find(metaclasses.nom == nom) 
	    #~ liste_activites = reste.split(";")
	    #~ if liste_classes[0].strip == "Cycle1" 
		#~ then cycle = 1 
		#~ else cycle = 2 
	    #~ end
	    #~ liste_classes.shift #Supprimer premier element du array
	  when "Classe"
	    puts "    classe : #{nom}  #{reste}"
	    #~ liste_classes = liste_classes.collect{|x| x.strip} #Remove trailing CR
	    # puts"[script/meta_classes.rb/debug01] liste_classes[0].strip = #{liste_classes[0].strip}"
	    #~ tmp = Classe.trouver(liste_classes[0].strip).periodes.to_i
	    #~ mc_new = Metaclass.new({	:nom => identifiant, 
					#~ :cycle => cycle, 
					#~ :periodes => tmp })
	    #puts mc_new
		#~ liste_classes.each do |cla_str| 
			#~ cla = Classe.trouver(cla_str.strip)
			#~ mc_new.ajouter_classe( cla ) 
	    #puts cla
		    #~ end	
		  #~ end	
		#~ end
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
      metaclasses.each{|mc| matieres << mc[0,3] }
      matieres.uniq!
  end



end
