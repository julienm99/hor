cd
cd hor13

#~ La filière SOURCE est la dernière (ex.: 102.txt) dans le répertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1) ; echo $derniere
SOURCE="op/cedulables/"$derniere


#~ La filière DESTINATION deviendra la dernière [ex.103.txt] dans le répertoire [hor13/op/cedulables/]
suivante=`expr substr $derniere 1 3`
suivante="$((suivante += 1))" 
suivante=$suivante".ceds"
DESTINATION="op/cedulables/"$suivante

#~ utile pour DEBUG
echo "VALIDER ------------------------"
echo "derniere:"$derniere
echo "SOURCE:"$SOURCE
echo "suivante: "$suivante
echo "argument de repartition: "$1
echo "DESTINATION: "$DESTINATION
echo "---------------------------------"


#~ $1 est la variable qui contient les metaclasses à valider (cedulables)
cat $SOURCE | ruby mapred/repartir.rb $1  | mapred/valider_01 > $DESTINATION


#~ ------------------------------
#~ -e la filière $DESTINATION existe-t-elle ?
#~ -s la filière $DESTINATION n'est pas vide (0 size).
#~ -n créer une filière $DESTINATION vide (0 byte) donc PAS DE SOLUTION
if [ -e $DESTINATION ] && [ -s $DESTINATION ]; 
  then echo $DESTINATION" contient des CEDULABLES"; 
  else echo -n > $DESTINATION ; echo "PAS DE SOLUTION"; 
fi
#~ ------------------------------


cd
cd rails_projects/hor