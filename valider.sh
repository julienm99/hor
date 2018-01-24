cd
cd hor13

derniere=$(ls op/cedulables -rt | tail -n1)
source="op/cedulables/"$derniere

suivante=${derniere:0:3}
suivante="$((suivante += 1))" 
suivante=$suivante".txt"
destination="op/cedulables/"$suivante

cat $source | ruby mapred/repartir.rb $1  | mapred/valider_01 > $destination
cd
cd rails_projects/hor