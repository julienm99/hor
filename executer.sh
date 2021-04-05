#~ -----------------------------------------------------------
#~ Cette filière exécutable est normalement lancée par  ~/rails_projects/hor/app/views/hor/action.htlm.erb  
#~ -----------------------------------------------------------

cd
cd hor13

     #~ La filière SOURCE est la dernière (ex.: 102.ceds) du répertoire [~/op/cedulables/]
     # Variables [$1...$7] reçues de la filière [~/rails_projects/hor/app/views/hor/action.html.erb]
dirCeds="/home/"$USER"/hor13/op/cedulables/"
dirRailsPublic="/home/"$USER"/rails_projects/hor/public/"
derniere=$(ls op/cedulables -rt | tail -n1)
SOURCE=$dirCeds$derniere
rem=$7
choix=$6

     echo "-----------------------------------------------------"
     echo "AFFICHER À L'ÉCRAN LES OPÉRATIONS "
     echo $rem
     echo "DES METACLASSES SÉLECTIONNÉES: HORAIRE-JDLM "$(date +%Y)
     echo "À PARTIR DE LA DERNIÈRE FILIÈRE DU RÉPERTOIRE:"
     echo "["$SOURCE"]"
     echo "-----------------------------------------------------"
     echo "RÉPERTOIRE -> "$(pwd)
     echo "-----------------------------------------------------"


     echo "CHOIX:       "$choix
case $choix in
     init)
          SEGMENT=$1; switch=$2; fname=$3
          echo "INITIALISATION (Contenu de "$fname" au départ --> {nil})" 
          echo "1-SEGMENT:  "$SEGMENT
          echo "2-SWITCH:   "$switch
          echo "3-FILIÈRE:  "$fname;;
     segMetas)
          SEGMENT=$1; switch=$2; metas=$3; ACTION=$6
          echo "1-SEGMENT:  "$SEGMENT
          echo "2-SWITCH:   "$switch
          echo "3-METAS:    "$metas;;
     segment)
          SEGMENT=$1; switch=$2; metas=$5; ACTION=$1 
          echo "1-SEGMENT:  "$SEGMENT
          echo "2-SWITCH:   "$switch
          echo "5-METAS:    "$metas
          if [ $switch = "-o" ]  ; then cp $dirRailsPublic"4-en_traitement.txt" $dirRailsPublic"temp_traitement.txt"; fi
          if [ $switch = "-oa" ] ; then cp $dirRailsPublic"temp_traitement.txt" $dirRailsPublic"4-en_traitement.txt"; fi ;;
     ceduler)
          ACTION=$1; niv=$2; maxSols=$3; jour=$4
          echo "1-ACTION     "$ACTION
          echo "2-NIVEAU     "$niv
          echo "3-MAX_SOLS   "$maxSols
          if [ -z "$jour" ]; then echo "4-JOURS      A B C D E F G H"; else echo "4-JOUR       "$jour; fi
          if [ $ACTION = "ceduler" ] ; then enregistre="oui" ; else enregistre="non" ; fi
          echo "5-ENREGISTRE "$enregistre;;
     diago)
          ACTION=$1; niv=$2
          echo "1-ACTION     "$ACTION
          echo "2-NIVEAU     "$niv;;
     * ) ;;
esac
     echo "-----------------------------------------------------"
     echo "EXÉCUTION: "$rem
cd
cd go/src/github.com/myrer/gobit
     echo "-----------------------------------------------------"
     echo "RÉPERTOIRE -> "$(pwd)
     echo "-----------------------------------------------------"
if [ $ACTION = "diago" ]
     then
          echo "EXÉCUTION --> ruby rbf/ag.rb "$niv  ; exit 
          ruby rbf/ag.rb $niv
     else 
          echo "EXÉCUTION --> ruby rbf/gobit4.rb "$1" "$2" "$3" "$4
          cat $SOURCE | ruby rbf/gobit4.rb $1 $2 $3 $4
fi
cd
cd rails_projects/hor
     echo "-----------------------------------------------------"
     echo "RÉPERTOIRE -> "$(pwd)
     echo "-> retour à HORAIRE-JDLM (web)"
     echo "-----------------------------------------------------"
