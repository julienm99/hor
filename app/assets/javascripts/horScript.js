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
  //~ if (arguments[0] == "infoHoraire")    { window.location.replace("/"); };
  //~ if (arguments[0] == "infoCedulables") { window.location.replace("/"); };
  //~ if (arguments[0] == "BaseDeDonnees")  { window.location.replace("/"); };

  // BOTTOM: boutons --------------------------------------------------------------------------- 
  //~ if (arguments[0] == "valider")        { window.location.replace("/"); };
  //~ if (arguments[0] == "invalider")      { window.location.replace("/"); };
  //~ if (arguments[0] == "filtrer")        { window.location.replace("/"); };


  // metaclasses: TOUTES et BACKBONE -------------------------------------------------------
  //~ if (arguments[0] == "index")          { window.location.replace("/"); } 
  //~ else { var path = "/blocMetaclasses?blocMC="+arguments[0];
	  //~ window.location.replace(path);};
 
  switch(arguments[0]) {
    case "4-en_traitement" :
      window.location.replace("/");
      break;
    case "infoCedulables" :
      window.location.replace("/");
      break;
    case "index":
      window.location.replace("/");
      break;
    case "valider":
      window.location.replace("/");
      break;
    default:
      var path = "/blocMetaclasses?blocMC="+arguments[0];
      window.location.replace(path);
  }
}


