cd
cd hor13

#~ La '$FILIEREaEFFACER' est la derni�re (ex.: 102.txt) dans le r�pertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
FILIEREaEFFACER="op/cedulables/"$derniere

rm $FILIEREaEFFACER


cd
cd rails_projects/hor