#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT:
     #~ AJOUTER les derniers diagonalises dans les horaires deja fixes.
     #~ TRANSFERER les horaires dans le PAS (Programmation de l'Annee Scolaire) dans le web
     #~ FOMER les filieres INFO_XXX.txt dans le repertoire [hor13/op/info/...]
     #~ AFFICHER les horaires des groupes (a titre d'exemple dans le terminal)
echo
echo "----------------------------------------------------"
echo "FIXER L'HORAIRE DES DERNIERS CEDULABLES DIAGONALISES"
echo "----------------------------------------------------"
echo
echo "POSITIONNER: repertoire ---> hor13"
cd
cd hor13
echo "----------------------"
echo "SAUVEGARDER l'horaire en cours: horaires.txt ---> horairesTemp.txt"
cp data/horaires.txt data/horairesTemp.txt
echo "----------------------"
echo "AJOUTER: Les metaclasses suivantes a l'horaire deja fixe: "
echo "["$1"]"
ruby script/format_horaire_string.rb $1 >> data/horaires.txt
echo "----------------------"
echo "SAUVEGARDER l'horaire diagonalise: horaires.txt ---> horairesCeds2pas.txt"
cp data/horaires.txt data/horairesCeds2pas.txt
echo "----------------------"
echo "TRANSFERER l'horaire [diagonalise] dans le PAS (Programmation de l'Annee Scolaire) WEB"
ruby mapred/http.rb
echo "----------------------"
echo "FORMER Les filieres [INFO_***.txt] selon la filiere [data/horaires.txt]"
./info.sh
echo "----------------------"
echo "AFFICHER: L'HORAIRE DES GROUPES"
cat info/info_HORAIRE_Gr.txt
echo "----------------------"
echo "POSITIONNER: repertoire ---> rails_projects/hor"
cd
cd rails_projects/hor


