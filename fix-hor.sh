echo
echo "-------------------------------------------"
echo "FIXER L'HORAIRE DES DERNIERS CEDULABLES"
echo "-------------------------------------------"


echo
echo "changement du repertoire ---> hor13"
cd
cd hor13
echo "----------------------"


echo "savegarde de l'horaire en cours: horaires.txt ---> horairesTemp.txt"
cp data/horaires.txt data/horairesTemp.txt
echo "----------------------"


echo "Metaclasses ajoutees a l'horaire deja fixe: "
echo "["$1"]"
ruby script/format_horaire_string.rb $1 >> data/horaires.txt
cp data/horaires.txt data/horairesTaches.txt
echo "----------------------"


derniere=$(ls op/cedulables -rt | tail -n1)

echo "formation des filieres [INFO_***.txt] selon la 1re ligne de la filiere "$derniere
./info.sh
echo "----------------------"



cat info/info_HORAIRE_Gr.txt


cd
cd rails_projects/hor


