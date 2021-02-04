#! /bin/bash --login
#~ REM: ENVIRONNEMENT -------------------------
cd ; cd hor13 ; # rvm use jruby 1.7.27 ; ruby -v

# REM: FONCTION EX…CUTIVE ------------------------
function executer {
  datesParade="$annee,$dateParade1,$dateParade2"
  ruby parade/confection/email.rb "$datesParade" "$dsp" "$dspMail" "$pedagoMail" "$testMail" "$params"
  }
  

#~ REM: PRINCIPALES VARIABLES -----------------------
  annee="2020"
  dateParade1="mardi 8 septembre 2020"
  dateParade2="mercredi 9 septembre 2020"
  dsp='Nathalie Provost'			# dsp = Direction des Services PÈdagogiques
  dspMail='provostn@jdlm.qc.ca'           	
  pedagoMail='pedagogie@jdlm.qc.ca'       	
  testMail='michel_julien@videotron.ca' 	


#~ PRINCIPAUX DOCUMENTS ‡ vÈrifier ------------------------------
  params="documents"               		# IMPORTANT: VÈrifier le contenu de chacun des documents [parade/op/pdf/...]


#~ COURRIELS PROFS -----------------------------------------------
  #~ profsTest="Robip,Angm,boum"					
  #~ params="courrielsProfs:cycle=1:test=oui:modification=non:type="$profsTest":envoi=non"	# Pas d'espace: BON:{test=oui}  PAS BON{test = oui} 

  #~ params="courrielsProfs:cycle=1:modification=non:envoi=non"         	
  #~ params="courrielsProfs:cycle=2:modification=non:envoi=non"         	


#~ COURRIELS PARENTS (responsables)  ------------------------------
  #~ params="validerCourriels"			# CaractËre(s) non permis = [‡¿‚¬È…Ë»Í ÎÀÓŒˆ÷Ù‘˘Ÿ˚€]

  #~ groupeTest="Gr303"
  #~ params="courrielsParents:test=oui:modification=non:type="$groupeTest":envoi=oui" # VÈrifier: message cycle1-2 + S3 pour message et l'heure du dÈbut

  #~ groupe="Gr201,Gr202,Gr203"				# Seulement des groupes du mÍme niveau (si plusieurs)
  #~ params="courrielsParents:test=non:modification=non:type="$groupe":envoi=non" 		  	


#~ COURRIELS PARTICULIERS  ------------------------------
  #~ cycle="2" ;  profs="Boum,lahg" 
  #~ params="courrielsProfsChoisis:cycle="$cycle":test=oui:modification=non:type="$profs":envoi=non"

  #~ niv="S1"; numEleve="8792,9704,"
  #~ numEleve=$numEleve"8792,9704,8792,9704,8792,9704,8792,9704,8792,9704,8792,9704,8792,9704,8792,9704"
  #~ params="courrielsNumEleve:niv="$niv":test=non:modification=non:type="$numEleve":envoi=oui"
  

#~ REM: COMMANDES D'EX…CUTION + SORTIE DU SHELL ---------
executer

rvm use 2.5.0
logout