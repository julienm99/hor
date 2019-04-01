cd
cd hor13

echo "VALIDER ------------------------"
#~ La fili�re SOURCE est la derni�re (ex.: 102.txt) dans le r�pertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
SOURCE="op/cedulables/"$derniere


#~ La fili�re DESTINATION deviendra la derni�re [ex.103.txt] dans le r�pertoire [hor13/op/cedulables/]
suivante=`expr substr $derniere 1 3`
suivante="$((suivante += 1))" 
suivante=$suivante".ceds"
DESTINATION="op/cedulables/"$suivante


#~ utile pour DEBUG
echo "SOURCE:      "$SOURCE
echo "DESTINATION: "$DESTINATION
echo "Argument de repartition: "$1
echo "---------------------------------"


#~ $1 est la variable qui contient les metaclasses � valider (deviendront cedulables s'il y a des solutions)

#~ Cette ligne donne imm�diatement � l'�cran du terminal les solutions pendant la recherche
#~ cat $SOURCE | ruby mapred/repartir.rb $1  | mapred/valider_01 > $DESTINATION | tail -f $DESTINATION

cat $SOURCE | ruby mapred/repartir.rb $1  | mapred/valider_01 > $DESTINATION 

#~ Si repartir.rb ne fonctionne pas, cedulable2.rb devrait mais est beaucoup plus lent (d�commenter)
#~ cat $SOURCE | ruby mapred/repartir.rb $1  | ruby mapred/cedulable2.rb > $DESTINATION


#~ ------------------------------
#~ Signification des lettres e, s, n:
#~ -e la fili�re $DESTINATION existe-t-elle ?
#~ -s la fili�re $DESTINATION n'est pas vide (0 < size).
#~ -n cr�er une fili�re $DESTINATION vide (0 byte) donc PAS DE SOLUTION
#~ ------------------------------
if [ -e $DESTINATION ] && [ -s $DESTINATION ]; 
  then 
    echo $DESTINATION" contient des CEDULABLES"; 
  else
    #~ rm $DESTINATION
    #~ echo -n > $DESTINATION  
    echo "PAS DE SOLUTION" 
fi
#~ ------------------------------

cd
cd rails_projects/hor