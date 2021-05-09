#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appelee par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
      #~ Fixer la premi�re solution des C�DULABLES que l'on vient de trouver dans [hor13/data/horaires.txt].
      #~ Pour �tre en mesure de consulter le r�pertoire des info partielles qui sont form�es [./info.sh]
      #~ Revenir au statut pr�c�dent
      
#~ PROCÉDURES:
     #~ SAUVEGARDER l'horaire en cours dans [hor13/data/horairesTemp.txt]
     #~ PRENDRE la premiere solution de la derniere filieres [hor13/op/cedulables/xxx.ceds]
     #~ 	cette operation a ete effectuee dans [hor/app/views/hor/_action.html.erb] 
     #~ 	c'est la solution placée dans la variable [$2] de cette filiere qui est mis en argument
     #~ FIXER cette solution (temporairement)
     #~ SAUVEGARDER la cette solution dans [hor13/data/horairesCeds2pas.txt]
     #~ [option de] TRANSFERER cette solution dans le PAS (Planification Annee Scolaire) dans le web
     #~ FOMER les filieres INFO_XXX.txt dans le repertoire [hor13/op/info/]
     #~ REVENIR au statut precedent 
     
      #echo "-----------------------------------------------------"
      #echo "FIXER LE PREMIER HORAIRE DE LA DERNIERE FILIERE DE CEDULABLES"
      #echo "     ET PRODUIRE LES INFO-HORAIRES EN FIXANT"
      #echo "      TEMPORAIREMENT LA PREMIERE SOLUTION"
      #echo "-----------------------------------------------------"
      #echo
cd ; cd hor13

transfert_PAS=$1
metas=$2
objets=$3 
count=$4
execute=$5    
derniere=$(ls $GOBIT_DATA/op/cedulables -rt | tail -n1)
      #echo "La derniere filiere de cedulables traitee est:---> ["$derniere"]"
      #echo "----------------------"
cp data/horaires.txt data/horairesTemp.txt 
if [ $execute = "infoCeds" ] ; then ruby script/format_horaire_TACHES.rb $metas >> data/horaires.txt ; fi
if [ $execute = "infoCeds" ] ; then ./info.sh ; fi
if [ $execute = "infoHorTous" ] ; then ./info.sh $objets $count $execute $derniere ; fi

cp data/horaires.txt data/horairesCeds2pas.txt
if [ transfert_PAS = "oui" ]
 then
      #echo "TRANSFERER l'horaire des cedulables dans le PAS (Planification Annee Scolaire [web])"
      ruby mapred/http.rb
 fi


      #echo "FORMER: les filieres [INFO_***.txt] selon la 1re ligne de la filiere ["$derniere"]"

cp data/horairesTemp.txt data/horaires.txt

#echo "AFFICHER: l'horaire (temporaire) des Foyers (Groupes) à titre d'exemple"
      if [ -z "$objets" ] ; then
            #cat info/info_HORAIRE_Piscine.txt

            #cat info/info_HORAIRE_S5.txt
            #cat info/info_HORAIRE_S4.txt
            #cat info/info_HORAIRE_S3.txt
            cat info/info_HORAIRE_S2.txt
            #cat info/info_HORAIRE_S1.txt

            cd ; cd rails_projects/hor
      fi


