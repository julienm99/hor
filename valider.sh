cd
cd hor13

#~ La filière SOURCE est la dernière (ex.: 102.txt) dans le répertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
SOURCE="op/cedulables/"$derniere


#~ La filière DESTINATION deviendra la dernière [ex.103.txt] dans le répertoire [hor13/op/cedulables/]
suivante=`expr substr $derniere 1 3`
suivante="$((suivante += 1))" 
suivante=$suivante".txt"
DESTINATION="op/cedulables/"$suivante


#~ $1 est la variable qui contient les metaclasses à valider (cedulables)
cat $SOURCE | ruby mapred/repartir.rb $1  | mapred/valider_01 > $DESTINATION


cd
cd rails_projects/hor