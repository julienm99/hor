#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
     #~ FILTRER l'horaire en cours dans [hor13/data/horairesTemp.txt]
     #~ PRENDRE la premiere solution de la derniere filieres [hor13/op/cedulables/xxx.ceds]
echo "-----------------------------------------------------"
echo "ADDITIONNER LES DEUX FILI�RES EN JEU, FILTRER" 
echo "(les remettre filtrees dans leur r�pertoire)"
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
#~ La derni�re fili�re du r�pertoire [hor13/op/cedulables] est renomm�e {$SOURCE} 
#~ 	EXEMPLE: La fili�re 102.txt est renomm�e {$SOURCE} = 0_102.txt (conserv� pour s�curit�)
SOURCE="op/cedulables/0_"$derniere
echo "RENOMMER: la derniere filiere pour ARCHIVE "$SOURCE
mv "op/cedulables/"$derniere $SOURCE

echo "---------------------------"
echo "FILTRER: La derniere filiere aux "$1" lignes"
#~ La fili�re {$DESTINATION} renomm�e comme $derni�re [ex.102.ceds] dans le r�pertoire [hor13/op/cedulables/]
DESTINATION="op/cedulables/"$derniere
#~ RAPPEL:
#~ 	[$1 = intervalle en nombre de lignes] 
#~	[hor/app/helpers/application_helpers.rb : def obtenirIntervalleDerniereFiliereValider(diviseur)] 
#~ EXEMPLE: La fili�re 102.ceds contient 28 000 lignes est renomm�e: 0_102.ceds{#SOURCE}
#~ 	    la fili�re {#DESTINATION} apr�s traitement deviendra 102.ceds avec 11 lignes.
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
