cd
cd hor13

echo "---------------------------"
echo "   INVALIDER"
echo "---------------------------"



#~ La '$FILIEREaEFFACER' est la dernière (ex.: 102.ceds) dans le répertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
echo "derniere filiere avant l'effacement: "$derniere

#~ S'il y a eu échantillonnage il faut effacer la filière source de l'échantillonnage
if [ -e "op/cedulables/0_"$derniere ]
  then rm "op/cedulables/0_"$derniere
  echo "EFFACER:  0_"$derniere
fi

FILIEREaEFFACER="op/cedulables/"$derniere

rm $FILIEREaEFFACER

echo "FILIERE A EFFACER                  : "$FILIEREaEFFACER
echo "derniere filiere après l'effacement: "$(ls op/cedulables -rt | tail -n1)
echo "---------------------------"

cd
cd rails_projects/hor


if [ -e "op/cedulables/0_"$derniere ]
  then 
  echo $derniere
fi

