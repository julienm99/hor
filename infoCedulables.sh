echo "-------------------------------------------"
echo "FORMATION DES FILIERES: INFO_XX.txt"
echo "changement de repertoire ---> hor13"
echo "savegarde de l'horaire en cours: horaires.txt ---> horairesTemp.txt"
cd
cd hor13
cp data/horaires.txt data/horairesTemp.txt

echo "Métaclasses en jeu ------"
echo $1

ruby script/format_horaire_string.rb $1 >> data/horaires.txt
echo "-------------------------"

./info.sh


cp data/horairesTemp.txt data/horaires.txt
cd
cd rails_projects/hor
echo "Rappel de l'horaire en cours: horairesTemp.txt ---> horaires.txt"
echo "-------------------------------------------"
