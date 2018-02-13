cd
cd hor13

#~ La derni�re fili�re du r�pertoire [hor13/op/cedulables] est renomm�e {$SOURCE} 
#~ 	EXEMPLE: La fili�re 102.txt est renomm�e {$SOURCE} = 0102.txt-filtre
derniere=$(ls "op/cedulables" -rt | tail -n1)
SOURCE="op/cedulables/0_"$derniere

mv "op/cedulables/"$derniere $SOURCE


#~ La fili�re {$DESTINATION} deviendra la derni�re [ex.102.txt] dans le r�pertoire [hor13/op/cedulables/]
DESTINATION="op/cedulables/"$derniere

cd 
cd hor13
#~ RAPPEL [$1 = intervalle] [hor/app/helpers/application_helpers.rb : def obtenirIntervalleDerniereFiliereValider(diviseur)] 
#~ EXEMPLE: La fili�re {#SOURCE} 0102.txt-filtre contient 28 000 lignes.
#~ 	    la fili�re {#DESTINATION} apr�s traitement deviendra 102.txt avec 10 lignes.
cat $SOURCE | ruby mapred/select_interval.rb $1  > $DESTINATION


cd
cd rails_projects/hor