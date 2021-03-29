#~ -----------------------------------------------------------
#~ Cette filière est lancée par l'exécutable  ~/rails_projects/hor/executer.sh  
#~ BUTS: selon le choix ($6): c.f. voir EXÉCUTION ci-dessous 

cd
cd hor13

     #~ La filière SOURCE est la dernière (ex.: 102.ceds) du répertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
dirCeds="/home/"$USER"/hor13/op/cedulables/"
dirRailsPublic="/home/"$USER"/rails_projects/hor/public/"
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

     # Variables [$1...$7] reçues de la filière [~/rails_projects/hor/app/views/hor/action.html.erb]


     echo "CHOIX:     "$choix
     case $choix in
          init)
               SEGMENT=$1; switch=$2; fname=$3
               echo "INITIALISATION (Contenu de "$fname" au départ --> {nil})" 
               echo "1-SEGMENT:  "$SEGMENT
               echo "2-SWITCH:   "$switch
               echo "3-FILIÈRE:  "$fname;;
          segment)
               SEGMENT=$1; switch=$2; metas=$5 
               echo "1-SEGMENT:  "$SEGMENT
               echo "2-SWITCH:   "$switch
               echo "5-METAS:    "$metas
               if [ $switch = "-o" ]  ; then cp $dirRailsPublic"4-en_traitement.txt" $dirRailsPublic"temp_traitement.txt"; fi
               if [ $switch = "-oa" ] ; then cp $dirRailsPublic"temp_traitement.txt" $dirRailsPublic"4-en_traitement.txt"; fi ;;
          ceduler)
               ACTION=$1; niveau=$2; maxSols=$3; jour=$4; sauve=$5
               echo "1-ACTION     "$ACTION
               echo "2-NIVEAU     "$niveau
               echo "3-MAX_SOLS   "$maxSols
               echo "4-JOUR:      "$jour; if [ $jour = "" ]; then echo "A, B, C, D, E, F, G, H"; fi
               echo "5-ENREGISTRE "$sauve;;
          * ) ;;
     esac
     echo "-----------------------------------------------------"
     echo "EXÉCUTION: "$rem
cd
cd go/src/github.com/myrer/gobit
     echo "-----------------------------------------------------"
     echo "RÉPERTOIRE -> "$(pwd)
     echo "EXÉCUTION  -> ruby rbf/gobit4.rb"
     echo "-----------------------------------------------------"
cat $SOURCE | ruby rbf/gobit4.rb $1 $2 $3 $4
cd
cd rails_projects/hor
     echo "-----------------------------------------------------"
     echo "RÉPERTOIRE -> "$(pwd)
     echo "EXÉCUTION  -> retour à HORAIRE-JDLM (web)"
     echo "-----------------------------------------------------"
