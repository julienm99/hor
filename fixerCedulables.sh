echo
echo "-------------------------------------------"
echo "FIXER L'HORAIRE DES DERNIERS CÉDULABLES"
echo "-------------------------------------------"


echo
echo "changement du repertoire ---> hor13"
cd
cd hor13
echo "----------------------"


echo "savegarde de l'horaire en cours: horaires.txt ---> horairesTemp.txt"
cp data/horaires.txt data/horairesTemp.txt
echo "----------------------"


echo "$1=metaclassesEnJeu: obtenues ->[rails_projects/hor/app/views/fixerCedulables.html.erb]"
echo "Métaclasses ajoutées temporairement à l'horaire déjà fixé: ["$1"]"
ruby script/format_horaire_string.rb $1 >> data/horaires.txt
echo "----------------------"


derniere=$(ls op/cedulables -rt | tail -n1)

echo "formation des filières [INFO_***.txt] selon la 1re ligne de la filière "$derniere
./info.sh
echo "----------------------"


echo "Rappel de l'horaire en cours: horairesTemp.txt ---> horaires.txt"
cp data/horairesTemp.txt data/horaires.txt
echo "----------------------"


cd
cd rails_projects/hor
