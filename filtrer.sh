cd
cd hor13

#~ La dernière filière du répertoire [hor13/op/cedulables] est renommée {$SOURCE} 
#~ 	EXEMPLE: La filière 102.txt est renommée {$SOURCE} = 0102.txt-filtre
derniere=$(ls "op/cedulables" -rt | tail -n1)
SOURCE="op/cedulables/0_"$derniere

mv "op/cedulables/"$derniere $SOURCE


#~ La filière {$DESTINATION} deviendra la dernière [ex.102.txt] dans le répertoire [hor13/op/cedulables/]
DESTINATION="op/cedulables/"$derniere

cd 
cd hor13
#~ RAPPEL [$1 = intervalle] [hor/app/helpers/application_helpers.rb : def obtenirIntervalleDerniereFiliereValider(diviseur)] 
#~ EXEMPLE: La filière {#SOURCE} 0102.txt-filtre contient 28 000 lignes.
#~ 	    la filière {#DESTINATION} après traitement deviendra 102.txt avec 10 lignes.
cat $SOURCE | ruby mapred/select_interval.rb $1  > $DESTINATION


cd
cd rails_projects/hor