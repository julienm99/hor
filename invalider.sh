cd
cd hor13

echo "---------------------------"
echo "   INVALIDER"
echo "---------------------------"



#~ La '$FILIEREaEFFACER' est la derni�re (ex.: 102.ceds) dans le r�pertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
echo "derniere filiere avant l'effacement: "$derniere

#~ S'il y a eu �chantillonnage il faut effacer la fili�re source de l'�chantillonnage
if [ -e "op/cedulables/0_"$derniere ]
  then rm "op/cedulables/0_"$derniere
  echo "EFFACER:  0_"$derniere
fi

FILIEREaEFFACER="op/cedulables/"$derniere

rm $FILIEREaEFFACER

echo "FILIERE A EFFACER                  : "$FILIEREaEFFACER
echo "derniere filiere apr�s l'effacement: "$(ls op/cedulables -rt | tail -n1)
echo "---------------------------"

cd
cd rails_projects/hor


if [ -e "op/cedulables/0_"$derniere ]
  then 
  echo $derniere
fi

