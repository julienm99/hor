cd
cd hor13

#~ La filière SOURCE est la dernière (ex.: 102.txt) dans le répertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
FILIEREaEFFACER="op/cedulables/"$derniere

rm $FILIEREaEFFACER


cd
cd rails_projects/hor