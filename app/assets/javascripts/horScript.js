
function metaclassesChoisies() {
  var mc = document.forms["listeMetaclasses"];
  var i, mcChecked = "";

  for (i = 0; i < mc.length; i++) {
      if (mc[i].checked) {
	  mcChecked +=  mc[i].value + " ";
      }
    }
  document.getElementById("choixMetaclasses").innerHTML = mcChecked;
    
  affiche();
}


function affiche() {
  document.getElementById("affiche").innerHTML;
}


function pageWeb() {
  // TOP: boutons --------------------------------------------------------------------------- 
  if (arguments[0] == "infoHoraire")    { window.location.replace("/"); };
  if (arguments[0] == "infoCedulables") { window.location.replace("/"); };

  // BOTTOM: boutons --------------------------------------------------------------------------- 
  if (arguments[0] == "valider")        { window.location.replace("/"); };


  // metaclasses: TOUTES et BACKBONE -------------------------------------------------------
  if (arguments[0] == "index")          { window.location.replace("/"); };
  if (arguments[0] == "backbone")       { window.location.replace("/backbone"); };
  
  // metaclasses: COURS/ACTIVITÉS/MATIÈRES --------------------------------------------------
  if (arguments[0] == "coursEPS")       { window.location.replace("/coursEPS"); };

  // metaclasses: NIVEAUX ------------------------------------------------------------------
  if (arguments[0] == "nivS1")          { window.location.replace("/nivS1"); };
  if (arguments[0] == "nivS2")          { window.location.replace("/nivS2"); };
  if (arguments[0] == "nivS3")          { window.location.replace("/nivS3"); };
  if (arguments[0] == "nivS4")          { window.location.replace("/nivS4"); };
  if (arguments[0] == "nivS5")          { window.location.replace("/nivS5"); };

  // metaclasses: GROUPES ------------------------------------------------------------------
  if (arguments[0] == "gr41")           { window.location.replace("/gr41"); };
  if (arguments[0] == "gr42")           { window.location.replace("/gr42"); };
  if (arguments[0] == "gr43")           { window.location.replace("/gr43"); };
  if (arguments[0] == "gr45")           { window.location.replace("/gr44"); };
  if (arguments[0] == "gr44")           { window.location.replace("/gr45"); };
  if (arguments[0] == "gr46")           { window.location.replace("/gr46"); };
  if (arguments[0] == "gr47")           { window.location.replace("/gr47"); };
  if (arguments[0] == "gr48")           { window.location.replace("/gr48"); };
  if (arguments[0] == "gr49")           { window.location.replace("/gr49"); };
  
  if (arguments[0] == "gr51")           { window.location.replace("/gr51"); };
  if (arguments[0] == "gr52")           { window.location.replace("/gr52"); };
  if (arguments[0] == "gr53")           { window.location.replace("/gr53"); };
  if (arguments[0] == "gr54")           { window.location.replace("/gr54"); };
  if (arguments[0] == "gr55")           { window.location.replace("/gr55"); };
  if (arguments[0] == "gr56")           { window.location.replace("/gr56"); };
  if (arguments[0] == "gr57")           { window.location.replace("/gr57"); };
  if (arguments[0] == "gr58")           { window.location.replace("/gr58"); };
  if (arguments[0] == "gr59")           { window.location.replace("/gr59"); };
  
  if (arguments[0] == "gr21")           { window.location.replace("/gr21"); };

  
}


