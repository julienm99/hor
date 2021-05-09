# VARIABLES
    metas=$1
    lastFile=$2
    niv=$3
    dirConfec=$HOR13"/confection/horaire.rb"

# BUT :
    echo "-----------------------------------------------------"
    echo "fixCeds.sh: sous-routine appelée par le programme [action.html.erb]" 
    echo "BUT:" 
    echo "  FORMER LA FILIÈRE [confection/horaire.rb] AVEC"
    echo "  LA 1re RÉPARTITION DE LA DERNIÈRE FILIÈRE DES CEDULABLES: "$lastFile
    echo

# RÉPARTITION des METAS
    echo "  RÉPARTITIONS des metas:"
    echo $metas
    echo

# CRÉATION de la filière [confection/horaire.rb]   
    echo "  CRÉER [confection/horaire.rb] avec la 1re repartition de [op/cedulables/"$lastFile"]"

    echo "# encoding: UTF-8"                                         >  $dirConfec
    echo "# Répartition venant de [hor13/op/cedulables/"$lastFile"]" >> $dirConfec
    echo \$LOAD_PATH "<< \"~/hor13\""                                >> $dirConfec
    echo                                                             >> $dirConfec
    echo "MetaClasse.fixer_repartitions(\""$metas"\")"               >> $dirConfec

# CRÉATION de la filière [echange/{niv}-1.choix]
    echo
    echo "FORMATION DE LA FILIÈRE : "$niv"-1.choix"
    echo "2.4\t"$metas"\"" > $GOBIT_DATA"/echange/"$niv"-1.choix"

# RETOUR au GUI: HORAIRE-JDLM
    cd ; cd rails_projects/hor
     echo
     echo "  La filière [confection/horaire.rb] a été créée avec succès."
     echo "  RÉPERTOIRE -> "$(pwd)
     echo "-----------------------------------------------------"
