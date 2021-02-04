#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appelee par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
      #~ Fixer la première solution des CÉDULABLES que l'on vient de trouver dans [hor13/data/horaires.txt].
      #~ Pour être en mesure de consulter le répertoire des info partielles qui sont formées [./info.sh]
      #~ Revenir au statut précédent
      
#~ PROCÉDURES:
     #~ SAUVEGARDER l'horaire en cours dans [hor13/data/horairesTemp.txt]
     #~ PRENDRE la premiere solution de la derniere filieres [hor13/op/cedulables/xxx.ceds]
     #~ 	cette operation a ete effectuee dans [hor/app/views/hor/_action.html.erb] 
     #~ 	c'est la solution placée dans la variable [$1] de cette filiere qui est mis en argument
     #~ FIXER cette solution (temporairement)
     #~ SAUVEGARDER la cette solution dans [hor13/data/horairesCeds2pas.txt]
     #~ [option de] TRANSFERER cette solution dans le PAS (Planification Annee Scolaire) dans le web
     #~ FOMER les filieres INFO_XXX.txt dans le repertoire [hor13/op/info/]
     #~ REVENIR au statut precedent 
     
echo "-----------------------------------------------------"
echo "FIXER LE PREMIER HORAIRE DE LA DERNIERE FILIERE DE CEDULABLES"
echo "     ET PRODUIRE LES INFO-HORAIRES EN FIXANT"
echo "      TEMPORAIREMENT LA PREMIERE SOLUTION"
echo "-----------------------------------------------------"
echo
cd
cd hor13
echo "----------------------"


transfert_PAS=$1
metaclasses=$2
derniere=$(ls op/cedulables -rt | tail -n1)


echo "La derniere filiere de cedulables traitee est:---> ["$derniere"]"
echo "----------------------"
echo "SAUVEGARDER: l'horaire en cours: horaires.txt ---> horairesTemp.txt"
cp data/horaires.txt data/horairesTemp.txt
echo "----------------------"
echo "FIXER (temporairement) la premiere solution de la derniere filiere de Cedulables:"
echo "["$metaclasses"] ----> data/horaires.txt"
ruby script/format_horaire_TACHES.rb $metaclasses >> data/horaires.txt
echo "----------------------"
echo "SAUVEGARDER: cet horaire temporaire dans [data/horairesCeds2pas.txt]"
cp data/horaires.txt data/horairesCeds2pas.txt
echo "----------------------"


if [ $transfert_PAS = "oui" ]
then
      echo "TRANSFERER l'horaire des cedulables dans le PAS (Planification Annee Scolaire [web])"
      ruby mapred/http.rb
      echo "----------------------"
fi


echo "FORMER: les filieres [INFO_***.txt] selon la 1re ligne de la filiere ["$derniere"]"
./info.sh 
echo "----------------------"
echo "RAPPELLER: l'horaire en cours: horairesTemp.txt ---> horaires.txt"
cp data/horairesTemp.txt data/horaires.txt
echo "----------------------"
echo "AFFICHER: l'horaire (temporaire) des Foyers (Groupes) à titre d'exemple"
cat info/info_HORAIRE_Gr.txt
echo "----------------------"
echo "POSITIONNER: repertoire ---> rails_projects/hor"
cd
cd rails_projects/hor


