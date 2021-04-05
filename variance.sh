#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
     echo "-----------------------------------------------------"
     echo "BUT:    ORDONNER selon la variance: la dernière filière du directoire"
     echo "RAPPEL: Plus petite est la variance meilleur elle est."
     echo "        [hor13/op/cedulables/?.ceds]"
     echo "-----------------------------------------------------"
cd
cd hor13
     echo "RÉPERTOIRE ACTUEL --> "$(pwd)
     echo "-----------------------------------------------------"
derniere=$(ls op/cedulables -rt | tail -n1)
dirCeds="op/cedulables/"

SOURCE=$dirCeds$derniere
DESTINATION=$SOURCE
TEMPORAIRE=$dirCeds"TEMPORAIRE.ceds"
     echo "derniere:    "$derniere
     echo "SOURCE:      "$SOURCE" ---> trouver la variance de chacun des cedulables"
     echo "TEMPORAIRE:  "$TEMPORAIRE" ---> filiere a ordonner (sort):"
     echo "DESTINATION: "$DESTINATION" ---> filiere resultante ordonnee"

     echo "---------------------------------"
     echo "COPIER: "$SOURCE" dans la filiere "$TEMPORAIRE401 
cp $SOURCE $TEMPORAIRE
     echo "---------------------------------"
     echo "1- CALCULER: LA VARIANCE de la filiere "$TEMPORAIRE
     echo "2- ORDONNER: la filiere "$TEMPORAIRE
     echo "3- COPIER: "$TEMPORAIRE" dans la filiere "$DESTINATION
cat $TEMPORAIRE | ruby mapred/variance.rb  | sort > $DESTINATION
     echo "---------------------------------"
     echo "EFFACER : la filiere "$TEMPORAIRE
rm $TEMPORAIRE

cd
cd rails_projects/hor
     echo "-----------------------------------------------------"
     echo "RÉPERTOIRE ACTUEL --> "$(pwd)
     echo "EXÉCUTION  --> retour à HORAIRE-JDLM (web)"
     echo "-----------------------------------------------------"
