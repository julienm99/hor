cd
cd hor13
cp data/horaires.txt data/horairesTemp.txt

#~ ruby script/format_horaire_string.rb $1 >> data/horaires.txt
ruby script/format_horaire_string.rb $1 >> data/horaires.txt

#~ ./info.sh

cp data/horairesTemp.txt data/horaires.txt
cd
cd rails_projects/hor