#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
     #~ SAUVEGARDER l'horaire en cours dans [hor13/data/horairesTemp.txt]
     #~ PRENDRE la premiere solution de la derniere filieres [hor13/op/cedulables/xxx.ceds]
     #~ 	cette operation a ete effectuee dans hor/app/views/hor/_action.html.erb 
     #~ 	c'est la solution dans la variable [$1] de cette filiere mis en argument)
     #~ FIXER cette solution (temporairement)
     #~ SAUVEGARDER la cette solution dans [hor13/data/horairesCeds2pas.txt]
     #~ TRANSFERER cette solution dans le PAS (Programmation de l'Annee Scolaire) dans le web
     #~ FOMER les filieres INFO_XXX.txt dans le repertoire [hor13/op/info/]
     #~ REVENIR au statut precedent 
echo "-----------------------------------------------------"
echo "FIXER UN HORAIRE DE LA DERNIERE FILIERE DE CEDULABLES"
echo "     ET PRODUIRE LES INFO-HORAIRE EN FIXANT"
echo "      TEMPORAIREMENT LA PREMIERE SOLUTION"
echo "-----------------------------------------------------"
echo
echo "ALLER au repertoire ---> [hor13]"
derniere=$(ls op/cedulables -rt | tail -n1)
cd
cd hor13
echo "----------------------"
echo "SAUVEGARDER de l'horaire en cours: horaires.txt ---> horairesTemp.txt"
cp data/horaires.txt data/horairesTemp.txt
echo "----------------------"
echo "FIXER (temporairement) la premiere solution de la derniere filiere des Cedulables:"
echo "["$1"] ----> data/horaires.txt"
ruby script/format_horaire_string.rb $1 >> data/horaires.txt
echo "----------------------"
echo "SAUVEGARDER cet horaire temporaire dans [data/horairesCeds2pas.txt]"
cp data/horaires.txt data/horairesCeds2pas.txt
echo "----------------------"
echo "TRANSFERER l'horaire [temporaire] dans le PAS (Programmation de l'Annee Scolaire) WEB"
ruby mapred/http.rb
echo "----------------------"
echo "FORMER Les filieres [INFO_***.txt] selon la 1re ligne de la filiere ["$derniere"]"
./info.sh
echo "----------------------"
echo "RAPPEL de l'horaire en cours: horairesTemp.txt ---> horaires.txt"
cp data/horairesTemp.txt data/horaires.txt
echo "----------------------"
echo "AFFICHAGE de l'horaire (temporaire) des Foyers (Groupes)"
cat info/info_HORAIRE_Gr.txt
echo "----------------------"
echo "ALLER au repertoire [rails_projects/hor]"
cd
cd rails_projects/hor


