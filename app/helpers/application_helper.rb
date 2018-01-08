module ApplicationHelper

  def lireMetaclasses
    fname = "public/metaclasses.txt"
    file = File.open(fname, "r:iso8859-1")
      while (line = file.gets)
	type, reste = line.split("::")
	
	case type.strip
	when "MetaClasse" 
	  nom, reste = reste.split("\t")
	  listeClasses = reste.split(";")
	  listeClasses.shift         # Supprimer premier element du array (CycleX)
	  listeClasses = listeClasses.collect{|x| x.strip} #Remove trailing CR
	  #~ puts"[meta_classe/debug01]listeClasses[0].strip = #{liste_classes[0].strip}"
	  mc = Metaclasse.new({ :nom 	       => nom, 
				:fixHoraire    => false,
				:fixCedulables => false,
				:checked       => false,
				:listeClasses  => listeClasses   
			      })
		#~ puts "debug 02 metaclasse: #{mc.nom} liste classes =#{mc.listeClasses}"
	when "Classe" 
	  nom, reste = reste.split("\t")
	  cours, groupe, periodes, periodesTache, semestre, prof, salle, listeFoyers = reste.split(";")
	  params = {
		:nom => nom, :cours => cours, :groupe => groupe, :periodes => periodes, 
		:periodesTache => periodesTache, :semestre => semestre, :prof => prof, 
		:salle => salle, :listeFoyers => listeFoyers
		}
	  listeClasses.each do |classe_str| 
	      classe = Classe.new(params)
	      #~ puts "debug 04 classe: mc : #{mc.nom} prof #{classe.prof} liste des foyers #{classe.listeFoyers}"
	  end
	else
	    
	end
	  
      end 
    file.close	
    
    Metaclasse.tous
    
  end

  def miseAjourMetaclasses
    fname = "public/metaclasses.txt"
    file = File.open(fname, "r:iso8859-1")
    
      while (line = file.gets)
	type, reste = line.split("::")
	
	case type.strip
	when "MetaClasse" 
	  nom, reste = reste.split("\t")
	  mc = Metaclass.create(nom: nom, fixHor: false, fixCedulables: false, checked: false)
	  
	when "Classe" 
	  nom, reste = reste.split("\t")
	  matiere, groupe, periodes, periodesTache, semestre, prof, salle, listeFoyers = reste.split(";")
	  activite = Activite.create(nom: nom, matiere: matiere, groupe: groupe, 
				  periodes: periodes, periodesTache: periodesTache, 
				  semestre: semestre, prof: prof, 
				  salle: salle, listeFoyers: listeFoyers,
				  metaclass: mc.nom
				  )
	else
	    
	end
	  
      end 
    file.close	
        
  end


  class MetaclasseBack
    
    attr_accessor :nom, :fixHoraire, :fixCedulables, :checked, :listeClasses,
		  :identifiant, :cycle, :niveau

    @@tous = []
    
    def initialize(params)
      @identifiant   = @nom = params[:nom]
      @fixHoraire    = false
      @fixCedulables = false
      @checked       = false
      @listeClasses  = params[:listeClasses]
      
      @@tous << self
    end		

   
    def show
	    puts "-"*25
	    puts "#{nom}"
	    @liste_classes.each do |classe|
		    puts classe
	    end	
    end
    
#-------Class methods

    def self.afficher
	@@tous.sort{|a,b| a.identifiant <=> b.identifiant}.each{|x| x.show}
    end
    
    def self.trouver(identifiant)
	@@tous.find{|x| x.identifiant == identifiant}
    end

    def self.tous
	@@tous.uniq.sort{|a,b| a.nom <=> b.nom}
    end
	    
    def self.obtenir_MetaclasseNommee(nom)
	@@tous.find {|metaclasse| metaclasse.nom == nom}
    end
    
    def self.obtenir_metaclasse_avec_classe(classe)
	@@tous.find {|metaclasse| metaclasse.liste_classes.include?(classe)}
    end
    
    def self.obtenir_metaclassesEPS
	@@tous.find_all {|metaclasse| /Eps/.match(metaclasse.nom) }
    end
    		    
  private	
    def determiner_niveau
	    @niveau = @listeClasses[0].niveau
    end
	
  end



  class Classe
  
    attr_accessor :identifiant, :nom, :cours, :groupe, :periodes, :periodesTache, :semestre,
		  :prof, :salle, :listeFoyers, :niveau
		  
    @@tous =[]				

    def initialize(params)
      @identifiant = @nom = params[:nom]
      @cours         = params[:cours]
      @groupe        = params[:groupe]
      @periodes      = params[:periodes]
      @periodesTache = params[:periodesTache]
      @semestre      = params[:semestre]
      @prof          = params[:prof]
      @salle         = params[:salle]
      @listeFoyers   = params[:listeFoyers]
      
      @@tous << self
    end
    
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
