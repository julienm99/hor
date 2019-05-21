#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: Diagonaliser les filières [niv]_compact.j[X]
echo "-----------------------------------------------------"
echo "DIAGONALISER LA FILIERE: [op/"$1"_compact.j"$2"]"
echo "-----------------------------------------------------"
echo
echo "POSITIONNER: repertoire ---> hor13"
cd
cd hor13

niv=$1
jour=$2
dernierJour="O"
metaClasses=$3
dirCompact="op/compact/"
dirDiag="op/diag/"

source=$dirCompact$niv"_compact.j"
destin=$dirDiag$niv"_diag.j"

	
if [ $jour = $dernierJour ]
then
  ruby script/format_horaire_TACHES.rb $metaClasses >> data/horaires.txt
  cp confection/horaire_vide.rb confection/horaire.rb 
  echo "--------------------------------"
  echo "DIAGONALISATION TERMINEE"
  echo
  echo "[data/horaires.txt] est mis a jour"
  echo "[confection/horaire.rb] est vide"
  echo "Continuer avec une filiere [nil]"
  echo "--------------------------------"
else
  cat $source$jour | ruby mapred/diagonaliser.rb $metaClasses | sort > $destin$jour
fi


echo "POSITIONNER: repertoire ---> rails_projects/hor"
cd
cd rails_projects/hor
