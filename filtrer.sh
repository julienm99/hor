#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
     #~ FILTRER l'horaire en cours dans [hor13/data/horairesTemp.txt]
     #~ PRENDRE la premiere solution de la derniere filieres [hor13/op/cedulables/xxx.ceds]
echo "-----------------------------------------------------"
echo "ADDITIONNER LES DEUX FILIÈRES EN JEU, FILTRER" 
echo "(les remettre filtrees dans leur répertoire)"
echo "-----------------------------------------------------"
echo
echo "POSITIONNER: repertoire ---> hor13"
cd
cd hor13

echo "--------------------------"
derniere=$(ls op/cedulables -rt | tail -n1)
echo "ADDITIONNER: op/cedulables_back/"$derniere" avec op/cedulables/"$derniere
cat "op/cedulables_back/"$derniere >> "op/cedulables/"$derniere

echo "---------------------------"
#~ La dernière filière du répertoire [hor13/op/cedulables] est renommée {$SOURCE} 
#~ 	EXEMPLE: La filière 102.txt est renommée {$SOURCE} = 0_102.txt (conservé pour sécurité)
SOURCE="op/cedulables/0_"$derniere
echo "RENOMMER: la derniere filiere pour ARCHIVE "$SOURCE
mv "op/cedulables/"$derniere $SOURCE

echo "---------------------------"
echo "FILTRER: La derniere filiere aux "$1" lignes"
#~ La filière {$DESTINATION} renommée comme $dernière [ex.102.ceds] dans le répertoire [hor13/op/cedulables/]
DESTINATION="op/cedulables/"$derniere
#~ RAPPEL:
#~ 	[$1 = intervalle en nombre de lignes] 
#~	[hor/app/helpers/application_helpers.rb : def obtenirIntervalleDerniereFiliereValider(diviseur)] 
#~ EXEMPLE: La filière 102.ceds contient 28 000 lignes est renommée: 0_102.ceds{#SOURCE}
#~ 	    la filière {#DESTINATION} après traitement deviendra 102.ceds avec 11 lignes.
cat $SOURCE | ruby mapred/select_interval.rb $1  > $DESTINATION
echo "SOURCE           : "$SOURCE
echo "DESTINATION      : "$DESTINATION
echo "Derniere filiere : "$(ls "op/cedulables" -rt | tail -n1) 

echo "---------------------------"
echo "COPIER: op/ceculables/"$derniere " dans op/cedulables_back/ "$derniere
cp "op/cedulables/"$derniere "op/cedulables_back/"$derniere

echo "----------------------"
echo "POSITIONNER: repertoire ---> rails_projects/hor"
cd
cd rails_projects/hor
