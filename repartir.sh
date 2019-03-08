cd
cd hor13

echo "REPARTIR ------------------------"
#~ La fili�re SOURCE est la derni�re (ex.: 102.txt) dans le r�pertoire [hor13/op/cedulables/]
derniere=$(ls op/cedulables -rt | tail -n1)
SOURCE="op/cedulables/"$derniere

if [$SOURCE="start.txt"]
then 
  SOURCE=""
fi

#~ utile pour DEBUG
echo "La source est la derniere filiere du repertoire."
echo "SOURCE:"$SOURCE
echo "METACLASSES EN JEU: "$1
echo "---------------------------------"


#~ $1 est la variable qui contient les metaclasses � r�partir
cat $SOURCE | ruby mapred/repartir.rb $1


cd
cd rails_projects/hor