#!/bin/bash
login
#~ -----------------------------------------------------------
#~ Filiere script d'une sous-routine appele par le programme Rails: [rails_projects/hor] (HORAIRE-JDLM)
#~ BUT: 
    #~ FORMER LA FILIERE [confection/horaire.rb] avec la repartition de la derniere filiere des cedulables
    #~ (Cette sous-routine reçoit la répartition dans la variable $1)
function ceduler {
    echo "CEDULER: "$niv"_sols.j"$jour	
echo "METACLASSES $1 dans la function ceduler----------------------"
echo $1

    cat $dirSols$source | ruby mapred/ceduler.rb $1 >  $dirSols$niv"_sols.j"$jour
    }
function variables {
    metaclasses=$1
    niv="S5"
    
    dirCeds="op/cedulables/" 
    dirSols="op/sols/"  
    dirCompact="op/compact/"$niv"/"  
    dirDiag="op/diag/"$niv"/" 
    dirReps="op/reps/"$niv"/"  
    reps=".reps" 
    ceds=".ceds"  
    sols=".sols"
    derniere=$(ls op/cedulables_back -rt | tail -n1) 

    ligne="\n--------------------------------------------------------------"
    
    source=$(ls $dirCeds -rt | tail -n1)
    
      suivante=`expr substr $source 1 3`
      suivante="$((suivante += 1))" 
    destin=$suivante
    }

variables

echo "-----------------------------------------------------"
echo "FORMER les filieres des SOLUTIONS "$NIV" [op/sols/"$niv"_sols.j"$jour"]"
echo "-----------------------------------------------------"
echo
echo "POSITIONNER: repertoire ---> hor13"
cd
cd hor13
echo "----------------------"
echo "FORMER LES FILIERES DES SOLUTIONS [op/sols/"$niv"_sols.jX]" 
    #~ jour="A" ; source="start.j"$jour  ; ceduler 
    #~ jour="B" ; source="start.j"$jour  ; ceduler 
    #~ jour="C" ; source="start.j"$jour  ; ceduler 
    #~ jour="D" ; source="start.j"$jour  ; ceduler 
    #~ jour="E" ; source="start.j"$jour  ; ceduler 
    #~ jour="F" ; source="start.j"$jour  ; ceduler 
    #~ jour="G" ; source="start.j"$jour  ; ceduler 
    jour="G" ; source="start.j"$jour  
	cat $dirSols$source | ruby mapred/ceduler.rb $1 >  $dirSols$niv"_sols.j"$jour
    #~ jour="H" ; source="start.j"$jour  ; ceduler
echo "----------------------"
echo "POSITIONNER: repertoire ---> rails_projects/hor"
cd
cd rails_projects/hor
