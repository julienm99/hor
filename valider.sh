cd
cd hor13
#~ metaClasses="EPS1A EPS1B EPS2A EPS2B EPS1C_29 EPS3B EPS4C_39 EPS4B_5B EPS5C_45 EPS5C_46"
cat op/cedulables/nil.txt | ruby mapred/repartir.rb $1  | mapred/valider_01
cd
cd rails_projects/hor