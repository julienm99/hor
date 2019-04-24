#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
     #~ Trier selon la variance la dernière filiere du directoire [hor13/op/cedulables/]
echo "-----------------------------------------------------"
echo "ORDONNER selon la variance: la dernière filiere du directoire"
echo "        [hor13/op/cedulables/?.ceds]"
echo "-----------------------------------------------------"
echo
echo "ALLER au repertoire ---> [hor13]"
cd
cd hor13
echo "-----------------------------------------------------"
#~ La filière SOURCE est la plus recente (ex.: 102.txt) dans le répertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
d="op/cedulables/"

SOURCE=$dirCeds$derniere
DESTINATION=$SOURCE
TEMPORAIRE=$dirCeds"TEMPORAIRE.ceds"

echo "derniere:    "$derniere
echo "SOURCE:      "$SOURCE" ---> trouver la variance de chacun des cedulables"
echo "TEMPORAIRE:  "$TEMPORAIRE" ---> filiere a ordonner (sort):"
echo "DESTINATION: "$DESTINATION" ---> filiere resultante ordonnee"
echo "---------------------------------"
echo "Copier la filiere SOURCE dans la filiere TEMPORAIRE" 
cp $SOURCE $TEMPORAIRE
echo "---------------------------------"
echo "CALCULER: LA VARIANCE de la filiere "$TEMPORAIRE
echo "ORDONNER: la filiere TEMPORAIRE et la copier dans la filiere "$DESTINATION
cat $TEMPORAIRE | ruby mapred/variance.rb  | sort > $DESTINATION
echo "---------------------------------"
echo "EFFACER : la filiere "$TEMPORAIRE
rm $TEMPORAIRE
echo "---------------------------------"
echo "RETOUR au repertoire [rails_projects/hor]"
cd
cd rails_projects/hor