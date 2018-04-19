cd
cd hor13

echo "REPARTIR ------------------------"
#~ La fili�re SOURCE est la derni�re (ex.: 102.txt) dans le r�pertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
SOURCE="op/cedulables/"$derniere


#~ utile pour DEBUG
echo "derniere:"$derniere
echo "SOURCE:"$SOURCE
echo "METACLASSES EN JEU: "$1
echo "---------------------------------"


#~ $1 est la variable qui contient les metaclasses � r�partir
cat $SOURCE | ruby mapred/repartir.rb $1 | tail -f $DESTINATION


#~ ------------------------------
#~ -e la fili�re $DESTINATION existe-t-elle ?
#~ -s la fili�re $DESTINATION n'est pas vide (0 size).
#~ -n cr�er une fili�re $DESTINATION vide (0 byte) donc PAS DE SOLUTION
#~ if [ -e $DESTINATION ] && [ -s $DESTINATION ]; 
  #~ then echo $DESTINATION" contient des CEDULABLES"; 
  #~ else echo -n > $DESTINATION ; echo "PAS DE SOLUTION"; 
#~ fi
#~ ------------------------------


cd
cd rails_projects/hor