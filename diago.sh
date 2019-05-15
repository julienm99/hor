#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
echo "-----------------------------------------------------"
echo "DIAGONALISER LES FILIERES [op/NIV_compact.jX] "
echo "-----------------------------------------------------"
echo
echo "POSITIONNER: repertoire ---> hor13"
cd
cd hor13
echo "------------------------------"
echo "metaClasses: "$1
echo "------------------------------"
metaClasses=$1
niv=$2
dirCompact="op/compact/"

jour=$3

echo "jour = "$jour
echo "niv = "$niv

#~ source=$dirCompact$niv"_compact.j"$jour
#~ destin=$dirDiag$niv"_diag.j"$jour
	
	#~ action="jour "$jour": diagonalisation :\n"$source" ---> "$destin ; afficher
	
	#~ cat $source | ruby mapred/diagonaliser.rb $metaClasses | sort > $destin



#~ echo "----------------------"
#~ echo "DEFINIR la variable dirConfec = hor13/confection/"
#~ dirConfec="confection/"
#~ echo "----------------------"
#~ echo "FORMER LA FILIERE [confection/horaire.rb] avec la repartition de la derniere filiere des cedulables"
#~ echo "# encoding: UTF-8"                   >  $dirConfec"horaire.rb"
#~ echo \$LOAD_PATH "<< \"~/hor13\""             >> $dirConfec"horaire.rb"
#~ echo "MetaClasse.fixer_repartitions(\""$1"\")" >> $dirConfec"horaire.rb"
#~ echo "----------------------"
#~ echo "POSITIONNER: repertoire ---> rails_projects/hor"
#~ cd
#~ cd rails_projects/hor
