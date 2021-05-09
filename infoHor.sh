#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT:
     #~ Si [oui] : TRANSFERER les horaires dans le PAS (Programmation de l'Annee Scolaire) dans le web
     #~ FOMER les filieres INFO_XXX.txt dans le repertoire [hor13/op/info/...]
     #~ AFFICHER les horaires des groupes (a titre d'exemple dans le terminal)
     
transfert_PAS=$1

echo "-----------------------------------------------------------------------"
echo "     BUT: FORMER LES FILIERES [hor13/info/...] des horaires officiels."
echo "            TRANSFERT dans le PAS : "$transfert_PAS"!"
echo "-----------------------------------------------------------------------"
      cd ; cd hor13
      echo "RÉPERTOIRE -> "$(pwd)
      echo "----------------------"
echo "SAUVEGARDER par prudencce [data/horaires.txt] dans [data/horairesTemp.txt]"
      cp data/horaires.txt data/horairesTemp.txt
if [ $transfert_PAS = "oui" ] ; then echo "TANSFERT au PAS" ; ruby mapred/http.rb ; fi
echo "FORMER: Les filieres [hor13/info/...] selon [data/horaires.txt] officiel"
      ./info.sh 
      cp data/horairesTemp.txt data/horaires.txt
echo "----------------------"
echo "AFFICHER l'horaire de la piscine à titre d'exemple"
      cat info/info_HORAIRE_Piscine.txt

      cd ; cd rails_projects/hor
      echo "----------------------"
      echo "RÉPERTOIRE -> "$(pwd)

