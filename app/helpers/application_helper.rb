module ApplicationHelper

def lire(metaClasses)
    File.open("public/metaclasses.txt").each do |line|  
	  id, reste = line.split("\t")  
	  metaClasses << id[12,id.size] if id[0,12] == "MetaClasse::"  
	end  
end


def afficher(metaClasses)
    metaClasses
end


end
