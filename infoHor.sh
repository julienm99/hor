#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT:
     #~ TRANSFERER les horaires dans le PAS (Programmation de l'Annee Scolaire) dans le web
     #~ FOMER les filieres INFO_XXX.txt dans le repertoire [hor13/op/info/...]
     #~ AFFICHER les horaires des groupes (a titre d'exemple dans le terminal)
echo "-----------------------------------------------------"
echo "TRANSFERER LES HORAIRES DANS LE PAS (Programmation de l'Annee Scolaire) Web"
echo "     FORMER LES FILIERES [hor13/info/...] des horaires officiels"
echo "-----------------------------------------------------"
echo "ALLER au repertoire ---> [hor13]"
cd
cd hor13
echo "----------------------"
echo "SAUVEGARDER par prudencce [data/horaires.txt] dans [data/horairesTemp.txt]"
cp data/horaires.txt data/horairesTemp.txt
echo "----------------------"
echo "TRANSFERER l'horaire [officiel] dans le PAS (Programmation de l'Annee Scolaire) WEB"
ruby mapred/http.rb
echo "----------------------"
echo "FORMER: Les filieres [hor13/info/...] selon [data/horaires.txt] officiel"
./info.sh 
echo "----------------------"
echo "AFFICHER l'horaire des Foyers (groupes) a titre d'exemple"
cat info/info_HORAIRE_Gr.txt
echo "----------------------"
echo "ALLER au repertoire [rails_projects/hor]"
cd
cd rails_projects/hor

