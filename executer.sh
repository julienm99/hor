#~ -----------------------------------------------------------
#~ Cette filière exécutable est normalement lancée par  ~/rails_projects/hor/app/views/hor/action.htlm.erb  
#~ -----------------------------------------------------------
     
# VARIABLES : [$1...$7] reçues de la filière [~/rails_projects/hor/app/views/hor/action.html.erb]
 #~ La filière SOURCE est la dernière (ex.: 102.ceds) du répertoire [~/op/cedulables/]
     cd ; cd hor13

     dirCeds=$GOBIT_DATA"/op/cedulables/"
     dirRailsPublic="/home/"$USER"/rails_projects/hor/public/"
     derniere=$(ls $GOBIT_DATA/op/cedulables -rt | tail -n1)
     SOURCE=$dirCeds$derniere
     rem=$7
     choix=$6

# AFFICHAGE AU TERMINAL
     echo "-----------------------------------------------------"
     echo "AFFICHER À L'ÉCRAN LES OPÉRATIONS "
     echo $rem
     echo "DES METACLASSES SÉLECTIONNÉES: HORAIRE-JDLM "$(date +%Y)
     if [ $choix = "diago" ] ; then
          "À PARTIR DE :"$GOBIT_DATA"/echange/"$niv"-4.compac"
      else
          echo "À PARTIR DE LA DERNIÈRE FILIÈRE DU RÉPERTOIRE:"
          echo "["$SOURCE"]"
          echo "-----------------------------------------------------"
          echo "RÉPERTOIRE -> "$(pwd)
          echo "-----------------------------------------------------"
     fi

# CHOIX
     echo "CHOIX:       "$choix
     case $choix in
          init)
               SEGMENT=$1; switch=$2; fname=$3; ACTION=$choix
               echo "INITIALISATION (Contenu de "$fname" au départ --> {nil})" 
               echo "1-SEGMENT:  "$SEGMENT
               echo "2-SWITCH:   "$switch
               echo "3-FILIÈRE:  "$fname;;

          segMetas)
               SEGMENT=$1; switch=$2; metas=$3; ACTION=$choix
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

          repartir)
               SEGMENT=$1; switch=$2; ACTION=$choix
               echo "1-SEGMENT:  "$SEGMENT
               echo "2-SWITCH:   "$switch;;

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

          fix_diago)
               ACTION=$1; niv=$2
               echo "1-ACTION     "$ACTION
               echo "2-NIVEAU     "$niv;;

          * ) ;;
     esac

# EXÉCUTION:
     echo "-----------------------------------------------------"
     echo -e "EXÉCUTION: "$rem

     cd ; cd $GOBIT
     echo "-----------------------------------------------------"
     echo "RÉPERTOIRE -> "$(pwd)
     echo "-----------------------------------------------------"


     case $ACTION in
          init)
          echo "nil" > $GOBIT_DATA"/op/cedulables/"$fname ;;

          diago)
               echo "EXÉCUTION --> ruby "$GOBIT"/rbf/ag.rb "$niv 
               ruby $GOBIT/rbf/ag.rb $niv;;

          fix_diago)
               echo "EXÉCUTION: FIXER l'horaire de "$niv
               cat $GOBIT_DATA/echange/$niv-4best.hor >> $GOBIT_DATA/data/horaires.txt
               echo "           COPIER l'horaire officiel dans hor13"
               cp $GOBIT_DATA/data/horaires.txt $HOR13/data/horaires.txt
               echo "           MISE À JOUR  des info"
               $HOR13/info.sh ;;

          *)
               echo "EXÉCUTION --> "$GOBIT"/ruby rbf/gobit4.rb "$1" "$2" "$3" "$4
               ruby $GOBIT/rbf/gobit4.rb $1 $2 $3 $4;;
     esac


# RETOUR: HORAIRE-JDLM
     cd ; cd rails_projects/hor
     echo "-----------------------------------------------------"
     echo "RÉPERTOIRE -> "$(pwd)
     echo "-> retour à HORAIRE-JDLM (web)"
     echo "-----------------------------------------------------"
