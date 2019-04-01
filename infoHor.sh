echo
echo "------------------------------------------------------------"
echo "FORMATION DES FILIERES: INFO_XX.txt et TRANSFERT dans PAS"
echo "------------------------------------------------------------"

cd
cd hor13

echo
echo "-------------------------------------------"
echo "Transfert de l'horaire fixe dans TACHES"
echo "-------------------------------------------"

cp data/horaires.txt data/horaires_TACHES.txt
#~ ruby mapred/http.rb

echo
echo "-------------------------------------------"
echo "FORMATION DES FILIERES INF_*.txt"
echo "-------------------------------------------"

./info.sh
cat info/info_HORAIRE_Gr.txt
echo "-------------------------------------------"


cd
cd rails_projects/hor