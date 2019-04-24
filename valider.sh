cd
cd hor13

echo "------------------------------"
#~ La filière SOURCE est la dernière (ex.: 102.txt) dans le répertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
SOURCE="op/cedulables/"$derniere


#~ DESTINATION (=$SOURCE+1) deviendra la dernière [ex.103.txt] dans le répertoire [hor13/op/cedulables/]
suivante=`expr substr $derniere 1 3`
suivante="$((suivante += 1))" 
suivante=$suivante".ceds"
DESTINATION="op/cedulables/"$suivante


#~ utile pour DEBUG
echo "SOURCE : "$SOURCE
echo "DESTIN.: "$DESTINATION
echo "------------------------------"
echo "Metaclasses: "$1
echo "------------------------------"

#~ $1 est la variable qui contient les metaclasses à valider (deviendront cedulables s'il y a des solutions)

#~ COMMENTER OU DECOMMENTER------------------- l'action employe regulierement

#~ Si valider_01.rb ne fonctionne pas, cedulable2.rb devrait mais est beaucoup plus lent (décommenter)
#~ action="CEDULABLE2"
#~ cat $SOURCE | ruby mapred/repartir.rb $1  | ruby mapred/cedulable2.rb > $DESTINATION

#~ Cette ligne donne immédiatement à l'écran du terminal les solutions pendant la recherche
#~ action="VALIDER a l'ecran"
#~ cat $SOURCE | ruby mapred/repartir.rb $1  | mapred/valider_01 > $DESTINATION | tail -f $DESTINATION

action="VALIDER"
cat $SOURCE | ruby mapred/repartir.rb $1  | mapred/valider_01 > $DESTINATION 

#~ action="CEDULABLE"
#~ cat $SOURCE | ruby mapred/repartir.rb $1  | bin/cedulable > $DESTINATION 

echo "---------------------------------"
echo "Action : "$action

#~ ------------------------------
#~ Signification des lettres e, s, n:
#~ -e la filière $DESTINATION existe-t-elle ?
#~ -s la filière $DESTINATION n'est pas vide (0 < size).
#~ -n créer une filière $DESTINATION vide (0 byte) donc PAS DE SOLUTION
#~ ------------------------------
if [ -e $DESTINATION ] && [ -s $DESTINATION ]; 
  then 
    echo "   [ "$DESTINATION" ] contient des CEDULABLES"; 
  else
    #~ rm $DESTINATION
    #~ echo -n > $DESTINATION  
    echo "   PAS DE SOLUTION !" 
fi
echo "---------------------------------"
echo "RETOUR au repertoire [rails_projects/hor]"
cd
cd rails_projects/hor