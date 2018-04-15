cd
cd hor13

echo "---------------------------"
echo "Echantilonnage � 11 "
echo "---------------------------"

#~ La derni�re fili�re du r�pertoire [hor13/op/cedulables] est renomm�e {$SOURCE} 
#~ 	EXEMPLE: La fili�re 102.txt est renomm�e {$SOURCE} = 0_102.txt-filtre
derniere=$(ls "op/cedulables" -rt | tail -n1)
SOURCE="op/cedulables/0_"$derniere

mv "op/cedulables/"$derniere $SOURCE


#~ La fili�re {$DESTINATION} renomm�e la derni�re [ex.102.ceds] dans le r�pertoire [hor13/op/cedulables/]
DESTINATION="op/cedulables/"$derniere

#~ RAPPEL [$1 = intervalle] [hor/app/helpers/application_helpers.rb : def obtenirIntervalleDerniereFiliereValider(diviseur)] 
#~ EXEMPLE: La fili�re 102.ceds contient 28 000 lignes est renomm�e: 0_102.ceds{#SOURCE}
#~ 	    la fili�re {#DESTINATION} apr�s traitement deviendra 102.ceds avec 11 lignes.
cat $SOURCE | ruby mapred/select_interval.rb $1  > $DESTINATION

echo "SOURCE           : "$SOURCE
echo "DESTINATION      : "$DESTINATION
echo "Derniere filiere : "$(ls "op/cedulables" -rt | tail -n1) 
echo "---------------------------"

cd
cd rails_projects/hor