cd
cd hor13

echo "STOP avec la commande: kill -9 $(lsof -i tcp:3000 -t)"

kill -9 $(lsof -i tcp:3000 -t)


cd
cd rails_projects/hor