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
cd ; cd hor13
  echo "----------------------"
  echo "RÉPERTOIRE -> "$(pwd)
  echo "----------------------"
  echo "svn update"
svn update
cd init
  echo "----------------------"
  echo "RÉPERTOIRE -> "$(pwd)


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

 cd ..
  echo "RÉPERTOIRE -> "$(pwd)

svn commit -m"BASE DE DONNEES ---> MISE A JOUR"
svn update
  echo "----------------------"
cd ; cd go/src/github.com/myrer/gobit
  echo "BASE DE DONNEES [gobit] ---> MISE À JOUR"
  echo "RÉPERTOIRE -> "$(pwd)
  echo "ruby rbf/gobit.rb --refresh"
ruby rbf/gobit.rb --refresh

cd ; cd hor13
cp data/horaires.txt data/horairesTemp.txt 
./info.sh "data"
cp data/horairesTemp.txt data/horaires.txt
  
cd ; cd rails_projects/hor
  echo "----------------------"
  echo "RÉPERTOIRE -> "$(pwd)
  echo "----------------------"
