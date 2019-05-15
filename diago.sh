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
echo "args0 ="$0
echo "------------------------------"
echo "args1 ="$1
echo "------------------------------"
echo "args2 ="$2
echo "------------------------------"
echo "args3 ="$3
echo "------------------------------"
echo "numbers of args. (#) are"$#
echo "------------------------------"


niv=$1
metaClasses=$2
dirCompact="op/compact/"
dirDiag="op/diag/"
source=$dirCompact$niv"_compact.j"
destin=$dirDiag$niv"_diag.j"
	
	
#~ jour="B";cat $source$jour | ruby mapred/diagonaliser.rb $metaClasses | sort > $destin$jour
	#~ $metaClasses=$metaclasses


#~ echo "----------------------"
#~ echo "DEFINIR la variable dirConfec = hor13/confection/"
#~ dirConfec="confection/"
#~ echo "----------------------"
#~ echo "FORMER LA FILIERE [confection/horaire.rb] avec la repartition de la derniere filiere des cedulables"
#~ echo "# encoding: UTF-8"                   >  $dirConfec"horaire.rb"
#~ echo \$LOAD_PATH "<< \"~/hor13\""             >> $dirConfec"horaire.rb"
#~ echo "MetaClasse.fixer_repartitions(\""$1"\")" >> $dirConfec"horaire.rb"
#~ echo "----------------------"
echo "POSITIONNER: repertoire ---> rails_projects/hor"
cd
cd rails_projects/hor
