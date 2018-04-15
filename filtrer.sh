cd
cd hor13

echo "---------------------------"
echo "Echantilonnage à 11 "
echo "---------------------------"

#~ La dernière filière du répertoire [hor13/op/cedulables] est renommée {$SOURCE} 
#~ 	EXEMPLE: La filière 102.txt est renommée {$SOURCE} = 0_102.txt-filtre
derniere=$(ls "op/cedulables" -rt | tail -n1)
SOURCE="op/cedulables/0_"$derniere

mv "op/cedulables/"$derniere $SOURCE


#~ La filière {$DESTINATION} renommée la dernière [ex.102.ceds] dans le répertoire [hor13/op/cedulables/]
DESTINATION="op/cedulables/"$derniere

#~ RAPPEL [$1 = intervalle] [hor/app/helpers/application_helpers.rb : def obtenirIntervalleDerniereFiliereValider(diviseur)] 
#~ EXEMPLE: La filière 102.ceds contient 28 000 lignes est renommée: 0_102.ceds{#SOURCE}
#~ 	    la filière {#DESTINATION} après traitement deviendra 102.ceds avec 11 lignes.
cat $SOURCE | ruby mapred/select_interval.rb $1  > $DESTINATION

echo "SOURCE           : "$SOURCE
echo "DESTINATION      : "$DESTINATION
echo "Derniere filiere : "$(ls "op/cedulables" -rt | tail -n1) 
echo "---------------------------"

cd
cd rails_projects/hor