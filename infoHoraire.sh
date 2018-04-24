cd
cd hor13
echo
echo "------------------------------------------------------------"
echo "FORMATION DES FILIERES: INFO_XX.txt et TRANSFERT dans TACHES"
echo "------------------------------------------------------------"
echo
echo "-------------------------------------------"
echo "Transfert de l'horaire fixé dans TACHES"
echo "-------------------------------------------"
cp data/horaires.txt data/horaires_TACHES.txt
ruby mapred/http.rb
echo
echo "-------------------------------------------"
echo "FORMATION DES FILIÈRES INF_*.txt"
echo "-------------------------------------------"
./info.sh
echo
cd
cd rails_projects/hor