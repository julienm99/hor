cd
cd hor13

if [ $jour = "A" ] ; then 
    echo "-----------------------------------------------------------";
    echo "  RÉPERTOIRE -> "$(pwd);
    echo "  Filiere exécutable lancée à partir de [action.html.erb]";
    echo "  BUT:"; 
    echo "      CRÉATION: [op/sols/"$niv"_sols.jX]";
    echo "  METACLASSES: "; 
    echo $metaclasses; 
    echo $ligne; 
fi 

function ceduler {
    cat $dirSols$source | ruby mapred/ceduler.rb $metaclasses > $dirSols$niv"_sols.j"$jour
    }

function variables {
    metaclasses=$1
    niv=$2
    jour=$3    
    dirSols="op/sols/"  
    ligne="\n-------------"
    }

variables

     echo "  CRÉATION: [op/sols/"$niv"_sols.j"$jour"]"

if [ $jour = "A" ] ; then source="start.j"$jour; ceduler; fi
if [ $jour = "B" ] ; then source="start.j"$jour; ceduler; fi
if [ $jour = "C" ] ; then source="start.j"$jour; ceduler; fi
if [ $jour = "D" ] ; then source="start.j"$jour; ceduler; fi
if [ $jour = "E" ] ; then source="start.j"$jour; ceduler; fi
if [ $jour = "F" ] ; then source="start.j"$jour; ceduler; fi
if [ $jour = "G" ] ; then source="start.j"$jour; ceduler; fi
if [ $jour = "H" ] ; then source="start.j"$jour; ceduler; fi

cd
cd rails_projects/hor

if [ $jour = "H" ] ; then echo; echo "  RÉPERTOIRE -> "$(pwd); echo $ligne; fi
