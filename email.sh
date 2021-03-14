#! /bin/bash --login
#~ REM: ENVIRONNEMENT -------------------------
cd ; cd hor13 ; # rvm use jruby 1.7.27 ; ruby -v

# REM: FONCTION EX�CUTIVE ------------------------
function executer {
  datesParade="$annee,$dateParade1,$dateParade2"
  ruby parade/confection/email.rb "$datesParade" "$dsp" "$dspMail" "$pedagoMail" "$testMail" "$params"
  }


#~ REM: PRINCIPALES VARIABLES -----------------------
  annee="2021"
  dateParade1="septembre 2021"
  dateParade2="septembre 2021"
  dsp='Nathalie Provost'			# dsp = Direction des Services P�dagogiques
  dspMail='provostn@jdlm.qc.ca'
  pedagoMail='pedagogie@jdlm.qc.ca'
  testMail='michel_julien@videotron.ca'


#~ PRINCIPAUX DOCUMENTS � v�rifier ------------------------------
  params="documents"               		# IMPORTANT: V�rifier le contenu de chacun des documents [parade/op/pdf/...]


#~ COURRIELS PROFS -----------------------------------------------
  #~ profsTest="Robip,Angm,boum"
  #~ params="courrielsProfs:cycle=1:test=oui:modification=non:type="$profsTest":envoi=non"	# Pas d'espace: BON:{test=oui}  PAS BON{test = oui}

  #~ params="courrielsProfs:cycle=1:modification=non:envoi=non"
  #~ params="courrielsProfs:cycle=2:modification=non:envoi=non"


#~ COURRIELS PARENTS (responsables)  ------------------------------
  #~ params="validerCourriels"			# Caract�re(s) non permis = [����������������������]

  #~ groupeTest="Gr303"
  #~ params="courrielsParents:test=oui:modification=non:type="$groupeTest":envoi=oui" # V�rifier: message cycle1-2 + S3 pour message et l'heure du d�but

  #~ groupe="Gr201,Gr202,Gr203"				# Seulement des groupes du m�me niveau (si plusieurs)
  #~ params="courrielsParents:test=non:modification=non:type="$groupe":envoi=non"


#~ COURRIELS PARTICULIERS  ------------------------------
  #~ cycle="2" ;  profs="Boum,lahg"
  #~ params="courrielsProfsChoisis:cycle="$cycle":test=oui:modification=non:type="$profs":envoi=non"

  #~ niv="S1"; numEleve="8792,9704,"
  #~ numEleve=$numEleve"8792,9704,8792,9704,8792,9704,8792,9704,8792,9704,8792,9704,8792,9704,8792,9704"
  #~ params="courrielsNumEleve:niv="$niv":test=non:modification=non:type="$numEleve":envoi=oui"


#~ REM: COMMANDES D'EX�CUTION + SORTIE DU SHELL ---------
executer

rvm use 2.5.0
logout
