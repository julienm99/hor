echo
echo "-------------------------------------------"
echo "FIXER L'HORAIRE DES DERNIERS CÉDULABLES"
echo "-------------------------------------------"
echo "changement de repertoire ---> hor13"
echo "savegarde de l'horaire en cours: horaires.txt ---> horairesTemp.txt"
cd
cd hor13
cp data/horaires.txt data/horairesTemp.txt


echo "Métaclasses en jeu ------"
echo $1
ruby script/format_horaire_string.rb $1 >> data/horaires.txt


echo "Placer l'horaire cédulables dans l'horaire en cours: horaires.txt ---> horaires_TACHES.txt"
cp data/horaires.txt data/horaires_TACHES.txt


echo "-------------------------------------------"
echo "Transfert de l'horaire cédulables dans TACHES"
echo "-------------------------------------------"
ruby mapred/http.rb


echo "formation des filières INFO_"
./info.sh


cd
cd rails_projects/hor
echo "Rappel de l'horaire en cours: horairesTemp.txt ---> horaires.txt"
echo "-------------------------------------------"
