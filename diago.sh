#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: Diagonaliser les filières [niv]_compact.j[X]
#
#~ VARIABLES -------------------------
niv=$1
jour=$2
dernierJour="O"
metaClasses=$3
dirCompact="op/compact/"
dirDiag="op/diag/"

source=$dirCompact$niv"_compact.j"
destin=$dirDiag$niv"_diag.j"
#--------------------------------------

echo "-----------------------------------------------------"
echo "POSITIONNER: repertoire ---> hor13/"
cd
cd hor13
echo 

	
if [ $jour = $dernierJour ]
then
  ruby script/format_horaire_TACHES.rb $metaClasses | sort >> data/horaires.txt
  cp confection/horaire_vide.rb confection/horaire.rb 
  echo "-----------------------------------------------------"
  echo "DIAGONALISATION TERMINEE:"
  echo
  echo "A --> [data/horaires.txt]: mis a jour au"$niv
  echo "B --> [confection/horaire.rb]:vide pour niveau suivant"
  echo "C --> ARCHIVER: Copier/coller: metaClassesJ0 dans le run.sh"
  echo "D --> CEDULER: prochain niveau -> DÉPART: filiere [nil]"
  echo "-----------------------------------------------------"
else
  echo "-------------*----*---------------------------------------"
  echo "DIAGONALISER | j"$jour" | [op/"$niv"_compact.j"$jour"] -> [op/"$niv"_diag.j"$jour"]"
  echo "-------------*----*---------------------------------------"
  cat $source$jour | ruby mapred/diagonaliser.rb $metaClasses | sort > $destin$jour
fi


echo "POSITIONNER: repertoire ---> rails_projects/hor/"
cd
cd rails_projects/hor
echo "-----------------------------------------------------"
