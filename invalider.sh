#!/bin/bash

#~ -----------------------------------
#~   Operator	          |        Description
#~ -----------------------|-----------
#~ ! EXPRESSION	          |  The EXPRESSION is false.
#~ -n STRING	          |  The length of STRING is greater than zero.
#~ -z STRING	          |  The lengh of STRING is zero (ie it is empty).
#~ STRING1 = STRING2	  |  STRING1 is equal to STRING2: if ["$string1" = "$string2"] les variables doivent etre entre guillemets
#~ STRING1 != STRING2	  |  STRING1 is not equal to STRING2
#~ INTEGER1 -eq INTEGER2  |  INTEGER1 is numerically equal to INTEGER2
#~ INTEGER1 -gt INTEGER2  |  INTEGER1 is numerically greater than INTEGER2
#~ INTEGER1 -lt INTEGER2  |  INTEGER1 is numerically less than INTEGER2
#~ -d FILE	          |  FILE exists and is a directory.
#~ -e FILE	          |  FILE exists.
#~ -r FILE	          |  FILE exists and the read permission is granted.
#~ -s FILE	          |  FILE exists and it's size is greater than zero (ie. it is not empty).
#~ -w FILE	          |  FILE exists and the write permission is granted.
#~ -x FILE	          |  FILE exists and the execute permission is granted.
#~ -----------------------------------


function invalider {
    echo "---------------------------"
    echo "   INVALIDER "$derniere
    echo "---------------------------"
    
    echo "Derniere filiere avant l'effacement: "$derniere
    
    #~ La '$FILIEREaEFFACER' est la dernière (ex.: 102.ceds) dans le répertoire [hor13/op/cedulables/]
    FILIEREaEFFACER="op/cedulables/"$derniere

    rm $FILIEREaEFFACER

    echo "FILIERE A EFFACER                  : "$FILIEREaEFFACER
    echo "Derniere filiere apres l'effacement: "$(ls op/cedulables -rt | tail -n1)
    echo "---------------------------"
  }


function variables {
    derniere=$(ls op/cedulables -rt | tail -n1)  # dernière filière du repertoire op/cedulables (ex. 602.ceds)
    dizaineFile=`expr substr $derniere 2 2`
    doubleZero="00"
  }

cd
cd hor13

variables 

if [ "$dizaineFile" != "$doubleZero" ] 
  then 
    invalider
  else
    echo "---------------------------"
    echo $derniere": PAS supprimee! (c'est une filiere de depart)"
    echo "---------------------------"
fi


cd
cd rails_projects/hor

