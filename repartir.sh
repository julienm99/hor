#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
     #~ AFFICHER a l'ecran les repartitions
echo "-----------------------------------------------------"
echo "AFFICHER A L'ECRAN LES REPARTITIONS POSSIBLES "
echo "     D'UNE SUITE DE METACLASSES DONNEES"
echo "A PARTIR DE LA DERNIERE FILIERE DU REPERTOIRE"
echo "        [hor13/op/cedulables/?.ceds]"
echo "-----------------------------------------------------"
echo
echo "ALLER au repertoire ---> [hor13]"
cd
cd hor13
echo "-----------------------------------------------------"

#~ La fili�re SOURCE est la derni�re (ex.: 102.txt) dans le r�pertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
suivante=`expr substr $derniere 1 3`
SEGMENT="$((suivante += 1))"
SOURCE="/hor13/op/cedulables/"$derniere
option=" -x"

#~ utile pour DEBUG
echo "La source est la derniere filiere du repertoire."
echo "SOURCE:             "$SOURCE
echo "SEGMENT:            "$SEGMENT
echo "OPTION:             "$option
echo "METACLASSES EN JEU: "$1
echo "Action: REPARTIR (Afficher a l'ecran seulement)"
echo "-----------------------------------------------------"

cd
cd go/src/github.com/myrer/gobit
#~ $1 est la variable qui contient les metaclasses � r�partir
cat $SOURCE | ruby rbf/gobit4.rb $SEGMENT $option

echo "---------------------------------"
echo "RETOUR au repertoire [rails_projects/hor]"
cd
cd rails_projects/hor