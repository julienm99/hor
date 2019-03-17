cd
cd hor13

svn commit -m"base de donnees:  mise à jour"

dirData="op/init/"

#~ echos pour DEBUG -------------------
echo "BASE DE DONNEES -----------------"
echo "SVN avant le renouvellement"; svn -r
echo "SVN renouvellement: BASE DE DONNEES"; echo svn -r
echo "---------------------------------"


cat $TEMPORAIRE | ruby mapred/variance.rb  | sort > $DESTINATION


cd
cd rails_projects/hor