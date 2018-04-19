cd
cd hor13

echo "REPARTIR ------------------------"
#~ La filière SOURCE est la dernière (ex.: 102.txt) dans le répertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
SOURCE="op/cedulables/"$derniere


#~ utile pour DEBUG
echo "derniere:"$derniere
echo "SOURCE:"$SOURCE
echo "METACLASSES EN JEU: "$1
echo "---------------------------------"


#~ $1 est la variable qui contient les metaclasses à répartir
cat $SOURCE | ruby mapred/repartir.rb $1 | tail -f $DESTINATION


#~ ------------------------------
#~ -e la filière $DESTINATION existe-t-elle ?
#~ -s la filière $DESTINATION n'est pas vide (0 size).
#~ -n créer une filière $DESTINATION vide (0 byte) donc PAS DE SOLUTION
#~ if [ -e $DESTINATION ] && [ -s $DESTINATION ]; 
  #~ then echo $DESTINATION" contient des CEDULABLES"; 
  #~ else echo -n > $DESTINATION ; echo "PAS DE SOLUTION"; 
#~ fi
#~ ------------------------------


cd
cd rails_projects/hor