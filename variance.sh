cd
cd hor13

#~ La fili�re SOURCE est la plus recente (ex.: 102.txt) dans le r�pertoire [hor13/op/cedulables/]
dirCeds="op/cedulables/"
derniere=$(ls $dirCeds -rt | tail -n1)

SOURCE=$dirCeds$derniere
DESTINATION=$SOURCE
TEMPORAIRE=$dirCeds"TEMPORAIRE.ceds"


cp $SOURCE $TEMPORAIRE

#~ echos pour DEBUG -------------------
echo "VARIANCE ------------------------"
echo "derniere:"$derniere
echo "SOURCE:"$SOURCE" ---> trouver la variance de chacun des cedulables"
echo "TEMPORAIRE:"$TEMPORAIRE" ---> sort:"
echo "DESTINATION: "$DESTINATION
echo "---------------------------------"


cat $TEMPORAIRE | ruby mapred/variance.rb  | sort > $DESTINATION

rm $TEMPORAIRE


cd
cd rails_projects/hor