#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
    #~ FORMER LA FILIERE [confection/horaire.rb] avec la repartition de la derniere filiere des cedulables
    #~ (Cette sous-routine reçoit la répartition dans la variable $1)
echo "-----------------------------------------------------"
echo "FORMER LA FILIERE [confection/horaire.rb] AVEC"
echo "LA PREMIÈRE RÉPARTITION DE LA DERNIERE FILIERE DES CEDULABLES"
echo "-----------------------------------------------------"
echo
echo "POSITIONNER: repertoire ---> hor13"
cd
cd hor13
echo "----------------------"
echo "DEFINIR la variable dirConfec = hor13/confection/"
dirConfec="confection/"
echo "----------------------"
echo "FORMER LA FILIERE [confection/horaire.rb] avec la repartition de la derniere filiere des cedulables"
echo "# encoding: UTF-8"                   >  $dirConfec"horaire.rb"
echo \$LOAD_PATH "<< \"~/hor13\""             >> $dirConfec"horaire.rb"
echo "MetaClasse.fixer_repartitions(\""$1"\")" >> $dirConfec"horaire.rb"
echo "----------------------"
echo "POSITIONNER: repertoire ---> rails_projects/hor"
cd
cd rails_projects/hor
