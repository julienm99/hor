#!/bin/bash
#~ data.sh est une filiere qui automatise le transfert de 8 filieres
#~ 	de l'interface web PAS (Planification de l'Annee Scolaire)
#~ 	telechargees dans le repertoire [hor13/init/]

function transfert {
          echo "Transfert: "$pas$dir$source" > "$destination
	  
          curl $pas$dir$source > $destination
    }
    

echo " Procedure de mise a jour de la BASE DE DONNEES"
echo
echo "----------------------"
echo "Repertoire hor13/"
cd
cd hor13
echo "----------------------"
echo "svn update"
svn update
echo "----------------------"
echo "Repertoire [hor13/init/]"
cd init


echo "----------------------"
pas=" https://murmuring-brook-31271-fork1.herokuapp.com/utilitaires/"
dir="hor13_exporter_" 
  source="foyer.txt"     ; destination="foyers.txt"     ; transfert
  source="salle.txt"     ; destination="salles.txt"     ; transfert
  source="enseignant.txt"; destination="profs.txt"      ; transfert
  source="metaclasse.txt"; destination="metaclasses.txt"; transfert
echo "----------------------"
dir="exporter_rb_" 
  source="foyers.txt"     ; destination="foyers.rb"     ; transfert
  source="salles.txt"     ; destination="salles.rb"     ; transfert
  source="profs.txt"      ; destination="profs.rb"      ; transfert
  source="metaclasses.txt"; destination="metaclasses.rb"; transfert
echo "----------------------"
pas="https://murmuring-brook-31271-fork1.herokuapp.com/"
dir="communications/" 
  source="go_ressources"  ; destination="metas.txt"     ; transfert
echo "----------------------"

echo "Repertoire [hor13/] et svn commit"
cd ..
svn commit -m"BASE DE DONNEES ---> MISE A JOUR"
svn update
echo "----------------------"
echo "Repertoire: [rails_projects/hor]"
cd
cd rails_projects/hor
echo "----------------------"
