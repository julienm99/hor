    echo "-----------------------------------------------------"
    echo "fixCeds.sh: sous-routine appelée par le programme [action.html.erb]" 
    echo "BUT:" 
    echo "  FORMER LA FILIÈRE [confection/horaire.rb] AVEC"
    echo "  LA 1re RÉPARTITION DE LA DERNIÈRE FILIÈRE DES CEDULABLES: "$2
    echo
    echo "  RÉPARTITIONS:"
    echo $1
cd
cd hor13
    echo
    echo "  RÉPERTOIRE -> "$(pwd)
    echo
dirConfec="confection/horaire.rb"
    echo "  CRÉER [confection/horaire.rb] avec la 1re repartition de [op/cedulables/"$2"]"

echo "# encoding: UTF-8"                                  >  $dirConfec
echo "# Répartition venant de [hor13/op/cedulables/"$2"]" >> $dirConfec
echo \$LOAD_PATH "<< \"~/hor13\""                         >> $dirConfec
echo                                                      >> $dirConfec
echo "MetaClasse.fixer_repartitions(\""$1"\")"            >> $dirConfec

cd
cd rails_projects/hor
     echo
     echo "  La filière [confection/horaire.rb] a été créée avec succès."
     echo "  RÉPERTOIRE -> "$(pwd)
     echo "-----------------------------------------------------"
