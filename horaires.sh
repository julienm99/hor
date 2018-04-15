#~ FILIERE COPIANT: [horaire.txt] ET [metaclasses.txt] DANS LE REPERTOIRE PUBLIC

#~ Copie des horaires fixés:  [$USER donne le nom de l'utilisateur courant]
SOURCE='/home/'$USER'/hor13/data/horaires.txt'
DESTINATION='/home/'$USER'/rails_projects/hor/public/1-horaire_fixe.txt'
 
cp -u $SOURCE $DESTINATION

echo "---------------------------------------------------------"
echo $SOURCE"  --- copie sur ---> "$DESTINATION
echo "---------------------------------------------------------"

#~ Copie des métaclasses: 
SOURCE='/home/'$USER'/hor13/init/metaclasses.txt'
DESTINATION='/home/'$USER'/rails_projects/hor/public/metaclasses.txt'
 
cp -u $SOURCE $DESTINATION

echo "---------------------------------------------------------"
echo $SOURCE"  --- copie sur ---> "$DESTINATION
echo "---------------------------------------------------------"
