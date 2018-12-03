function horaireJDLM() {
    window.location.replace("/");
}

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
  if (arguments[0] == "BaseDeDonnees")  { window.location.replace("/"); };
  if (arguments[0] == "blocMc")         { window.location.replace("/"); };

  // BOTTOM: boutons --------------------------------------------------------------------------- 
  if (arguments[0] == "valider")        { window.location.replace("/"); };
  if (arguments[0] == "invalider")      { window.location.replace("/"); };
  if (arguments[0] == "filtrer")        { window.location.replace("/"); };


  // metaclasses: TOUTES et BACKBONE -------------------------------------------------------
  if (arguments[0] == "index")          { window.location.replace("/"); };
  //~ if (arguments[0] == "backbone")       { window.location.replace("/backbone"); };
  
  // metaclasses: COURS/ACTIVITÉS/MATIÈRES --------------------------------------------------
  //~ if (arguments[0] == "coursANG")       { window.location.replace("/coursANG"); };
  //~ if (arguments[0] == "coursART")       { window.location.replace("/coursART"); };
  //~ if (arguments[0] == "coursEPS")       { window.location.replace("/coursEPS"); };
  //~ if (arguments[0] == "coursFRA")       { window.location.replace("/coursFRA"); };
  //~ if (arguments[0] == "coursMAT")       { window.location.replace("/coursMAT"); };
  //~ if (arguments[0] == "coursSCT")       { window.location.replace("/coursSCT"); };

}


