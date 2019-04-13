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
derniere=$(ls op/cedulables -rt | tail -n1)
cd
cd hor13
echo "-----------------------------------------------------"

#~ La filière SOURCE est la dernière (ex.: 102.txt) dans le répertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
SOURCE="op/cedulables/"$derniere


#~ utile pour DEBUG
echo "La source est la derniere filiere du repertoire."
echo "SOURCE:"$SOURCE
echo "METACLASSES EN JEU: "$1
echo "Action: REPARTIR.rb (Afficher a l'ecran)"
echo "-----------------------------------------------------"


#~ $1 est la variable qui contient les metaclasses à répartir
cat $SOURCE | ruby mapred/repartir.rb $1

echo "---------------------------------"
echo "RETOUR au repertoire [rails_projects/hor]"
cd
cd rails_projects/hor