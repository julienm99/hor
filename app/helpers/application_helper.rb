module ApplicationHelper

def lire(metaClasses)
    File.open("public/metaclasses.txt").each do |line|  
	  id, reste = line.split("\t")  
	  metaClasses << id[12,id.size] if id[0,12] == "MetaClasse::"  
	end  
end


def group_string(niv,i)
     i  > 9 ? ajout = "" : ajout = "0" 
     niv == "S1" ? gr ="Gr#{niv[1,1] + ajout + i.to_s}" : gr ="Gr#{niv[1,1] + i.to_s}"
end


end
