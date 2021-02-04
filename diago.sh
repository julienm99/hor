#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: Diagonaliser les filières [niv]_compact.j[X]
#
#~ VARIABLES -------------------------
niv=$1
jour=$2
dernierJour="Z"
metaClasses=$3
matieresFiltre=$4
jourDepart=$5

#~ matieresFiltre a la forme d'une [regular expression]="/FRA|ANG|MAT/"

dirCompact="op/compact/"
dirDiag="op/diag/"


source=$dirCompact$niv"_compact.j"
destin=$dirDiag$niv"_diag.j"
#--------------------------------------

cd
cd hor13
	
if [ $jour = $dernierJour ]
then
  ruby script/format_horaire_TACHES.rb $metaClasses | sort >> data/horaires.txt
  cp confection/horaire_vide.rb confection/horaire.rb 
  
  echo "-----------------------------------------------------"
  echo "DIAGONALISATION TERMINEE:"
  echo
  echo "*-> [data/horaires.txt]: mis a jour pour le niveau "$niv
  echo "*-> [confection/horaire.rb]: vide (pret) pour niveau suivant"
  echo "*-> a faire: [WEB: HORAIRE-JDLM] INFO / METTRE A JOUR: filieres info des horaires fixes"
  echo "*-> a faire: ARCHIVER: Copier/coller: metaClasses dans le ./run.sh"
  echo "*-> a faire: CEDULER: prochain niveau -> DEPART: filiere [nil]"
  echo "-----------------------------------------------------"
  
else
  echo "-------------*----*---------------------------------------"
  echo "DIAGONALISER | j"$jour" | [op/"$niv"_compact.j"$jour"] --> [op/"$niv"_diag.j"$jour"]"
  echo "-------------*----*---------------------------------------"
  
  cat $source$jour | ruby mapred/diagonaliser.rb $matieresFiltre $metaClasses | sort > $destin$jour
fi


cd
cd rails_projects/hor
